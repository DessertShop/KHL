# frozen_string_literal: true

module KHL
  # @example
  # # Rails Environment
  # params = KHL::Webhook.decompress(request.body.string)
  # encrypted_data = params[:encrypt]
  # raw_json = KHL::Webhook.decode("your_encrypt_key", encrypted_data)
  # message = KHL::Message.parse(raw_json)
  module Webhook
    # Decode the data
    # @param [String] encrypt_key Encrypt Key
    # @param [String] encrypted_data Encrypted data
    # @return [String] Decrypted data
    def self.decode(encrypt_key, encrypted_data)
      encrypted_data = Base64.strict_decode64(encrypted_data)
      cipher = OpenSSL::Cipher.new("aes-256-cbc")
      cipher.decrypt
      cipher.iv = encrypted_data[0..15]
      cipher.key = encrypt_key.ljust(32, "\0")
      cipher.update(encrypted_data) + cipher.final
    end

    # Decompress the data
    # @param [String] data Compressed data
    # @return [String] Decompressed data
    def self.decompress(data)
      Zlib::Inflate.inflate(data)
    end
  end
end
