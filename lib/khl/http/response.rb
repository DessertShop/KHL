# frozen_string_literal: true

require "active_support/core_ext/hash/indifferent_access"
require "active_support/hash_with_indifferent_access"

module KHL
  module HTTP
    class Response
      attr_reader :http_code, :body

      # @param [Net::HTTPResponse] raw_response The raw HTTP response
      def initialize(raw_response)
        @raw_response = raw_response
        @http_code = raw_response.code.to_i
        @body = ActiveSupport::HashWithIndifferentAccess.new(JSON.parse(@raw_response.body))
      end

      def data
        @body[:data]
      end

      # The code in the response body
      def code
        @body[:code]
      end

      def max_request_limit
        @raw_response["X-Rate-Limit-Limit"].to_i
      end

      def remain_request_limit
        @raw_response["X-Rate-Limit-Remaining"].to_i
      end

      def reset_limit_time
        @raw_response["X-Rate-Limit-Reset"].to_i
      end

      def limit_bucket
        @raw_response["X-Rate-Limit-Bucket"]
      end

      def limit?
        @http_code == 429 || !@raw_response["X-Rate-Limit-Global"].nil?
      end

      def success?
        http_code == 200 && code.zero?
      end

      def failed?
        !success?
      end

      def message
        @body[:message]
      end

      def page
        data.dig(:meta, :page) || 0
      end

      def page_size
        data.dig(:meta, :page_size) || 0
      end

      def page_total
        data.dig(:meta, :total) || 0
      end
    end
  end
end
