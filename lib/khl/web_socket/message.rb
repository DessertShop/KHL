# frozen_string_literal: true

module KHL
  module WebSocket
    class Message
      TYPES = %i[
        event
        hello
        ping
        pong
        resume
        reconnect
        resume_ack
      ].freeze

      attr_accessor :type, :data, :sn

      def self.parse(raw)
        return unless raw

        data = JSON.parse(raw)
        message = Message.new
        message.type = TYPES[data["s"]]
        message.data = data["d"]
        message.sn = data["sn"]
        message
      end

      def initialize(type: nil, data: nil, sn: nil)
        @type = type
        @data = data
        @sn = sn
      end

      def to_h
        {
          s: TYPES.index(type),
          d: data,
          sn: sn
        }
      end

      def to_json
        to_h.to_json
      end

      TYPES.each do |type|
        define_method("#{type}?") do
          @type == type
        end
      end
    end
  end
end
