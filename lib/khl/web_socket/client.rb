# frozen_string_literal: true

require "cgi"
require "eventmachine"
require "faye/websocket"
require "json"
require "uri"
require "zlib"

require_relative "message"

module KHL
  module WebSocket
    # Client for the KHL WebSocket API
    # @example
    # client = KHL::WebSocket.new(token: "bot_token")
    # Thread.new { client.run }
    # client.message.pop # Get message from queue
    class Client
      attr_reader :config, :url, :messages, :state

      # @param config [String] :token Bot token
      # @option config [String] :token_type Token type
      # @option config [String] :language Language
      # @option config [Boolean] :compress Compress
      def initialize(config)
        config[:compress] ||= false

        @config = config
        @http_gateway = HTTP::Gateway.new(config)
        @url = gateway_url
        @messages = Queue.new
        @sn = 0
        @state = :disconnected
        @ping_signal = false
        @resume_signal = false
        @ws = nil
      end

      # Only receive messages from the server
      def run
        EM.run {
          Signal.trap("INT") { EventMachine.stop }
          Signal.trap("TERM") { EventMachine.stop }

          @ws = Faye::WebSocket::Client.new(gateway_url)
          @state = :connecting

          EventMachine.add_periodic_timer(30) do
            EventMachine.add_timer(6) do
              if @ping_signal
                @state = :timeout

                unless reconnect
                  unless resume
                    @state = :disconnected
                    EventMachine.stop
                    rerun
                  end
                end
              end
            end

            # Send ping message
            @ws.send({s: 2, sn: @sn}.to_json)
            @ping_signal = true
          end

          @ws.on :message do |event|
            raw = config[:compress] ? Zlib::Inflate.inflate(event.data.pack("C*")) : event.data
            msg = Message.parse(raw)

            if msg.hello?
              @state = :connected
            elsif msg.pong?
              @ping_signal = false
            elsif msg.resume_ack?
              @resume_signal = false
            elsif msg.reconnect?
              @state = :reconnecting
              rerun
            elsif msg.event?
              messages << msg
              @sn = msg.sn
            end
          end
        }
      end

      private

      def gateway_url
        response = @http_gateway.index
        return nil unless response.success?

        uri = URI(response.data["url"])
        query = CGI.parse(uri.query)
        query["compress"] = config[:compress] ? 1 : 0
        uri.query = URI.encode_www_form(query)
        uri.to_s
      end

      def reconnect
        @state = :reconnecting
        @ping_signal = false

        @ws.send({s: 2, sn: @sn}.to_json)
        @ping_signal = true
        sleep(2)
        return true unless @ping_signal

        @ws.send({s: 2, sn: @sn}.to_json)
        @ping_signal = true
        sleep(4)
        return true unless @ping_signal

        false
      end

      def resume
        @state = :resuming
        @resume_signal = false

        @ws.send({s: 4, sn: @sn}.to_json)
        @resume_signal = true
        sleep(8)
        return true unless @resume_signal

        @ws.send({s: 4, sn: @sn}.to_json)
        @resume_signal = true
        sleep(16)
        return true unless @resume_signal

        false
      end

      def rerun
        @url = gateway_url
        @messages.clear
        @sn = 0
        @state = :disconnected
        @ping_signal = false
        @resume_signal = false
        @ws = nil

        EventMachine.stop
        run
      end
    end
  end
end
