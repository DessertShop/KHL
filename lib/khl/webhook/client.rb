# frozen_string_literal: true

module KHL
  module Webhook
    # Client for the KHL Webhook API
    # @example
    # client = KHL::Webhook::Client.new("https://foo.bar/callback", "your_challenge_token")
    # client.online? # => false
    # client.challenge # => true
    # client.online? # => true
    # data = client.parse_message(data_from_webhook)
    class Client
      attr_reader :key

      # @param [String] challenge_url The source url from the request
      # @param [String] challenge_token The challenge param from the request
      # @param [Hash] options Additional options
      # @option options [Boolean] :compress (true) Enable/disable compression
      # @option options [encrypt] :encrypt (false) Enable/disable encryption
      # @option options [String] :key (nil) Encryption key
      def initialize(challenge_url, challenge_token, options = {})
        @challenge_url = challenge_url
        @challenge_token = challenge_token

        @compress = options[:compress] || true
        @encrypt = options[:encrypt] || false
        @key = options[:key]

        raise ArgumentError, "key is required" if @encrypt && @key.nil?
      end

      # Do the challenge
      # @return [Boolean] The challenge success state
      def challenge
        uri = URI.parse(@challenge_url)
        res = Net::HTTP.post_form(uri, challenge: @challenge_token)
        if res.code == "200"
          @online = true
          return true
        end

        false
      end

      def compress?
        @compress
      end

      def encrypt?
        @encrypt
      end

      def online?
        @online || false
      end

      # Parse message from raw data
      # @param [String] data The raw data from the webhook
      # @return [KHL::Message] The parsed message
      def parse_message(data)
        if encrypt?
          data = decrypt(data)
        end

        if compress?
          data = decompress(data)
        end

        Message.parse(data)
      end

      private

      # Decode the data
      # @param [String] encrypted_data Encrypted data
      # @return [String] Decrypted data
      def decode(encrypted_data)
        return nil unless encrypt?

        encrypted_data = Base64.strict_decode64(encrypted_data)
        cipher = OpenSSL::Cipher.new("aes-256-cbc")
        cipher.decrypt
        cipher.iv = encrypted_data[0..15]
        cipher.key = key.ljust(32, "\0")
        cipher.update(encrypted_data) + cipher.final
      end

      # Decompress the data
      # @param [String] data Compressed data
      # @return [String] Decompressed data
      def decompress(data)
        return nil unless compress?

        Zlib::Inflate.inflate(data.pack("C*"))
      end
    end
  end
end
