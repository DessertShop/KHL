# frozen_string_literal: true

require "active_support/core_ext/string/inflections"
require "json"
require "net/http"
require "uri"

require_relative "response"

module KHL
  module HTTP
    # 接口基类
    class Base
      BASE_URL = "https://www.kaiheila.cn/api"
      API_VERSION = "v3"
      END_POINT = "#{BASE_URL}/#{API_VERSION}"

      attr_reader :config

      # @param config [Hash] Config
      # @option config [String] :token Bot token (required)
      # @option config [String] :token_type Token type
      # @option config [String] :language Language
      def initialize(config)
        raise ArgumentError, "missing token" unless config[:token]
        config[:token_type] ||= "Bot"
        config[:language] ||= "zh-cn"

        @config = config
      end

      # GET 请求
      def get(params = {})
        action = params.key?(:action) ? params.delete(:action) : action_name # 可在 params 中手动配置 action
        uri = URI("#{END_POINT}/#{resource_name}/#{action}")
        params = filter_params(params)
        uri.query = URI.encode_www_form(params)
        request = Net::HTTP::Get.new(uri)
        request["Authorization"] = "#{config[:token_type]} #{config[:token]}"
        raw_response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
          http.request(request)
        end

        Response.new(raw_response)
      end

      # POST 请求
      def post(params = {})
        action = params.key?(:action) ? params.delete(:action) : action_name
        uri = URI("#{END_POINT}/#{resource_name}/#{action}")
        request = Net::HTTP::Post.new(uri)
        request["Authorization"] = "#{config[:token_type]} #{config[:token]}"
        request["Content-type"] = "application/json"
        params = filter_params(params)
        request.body = JSON.generate(params)
        raw_response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
          http.request(request)
        end

        Response.new(raw_response)
      end

      # POST 文件请求
      def post_file(params = {})
        action = params.key?(:action) ? params.delete(:action) : action_name
        uri = URI("#{END_POINT}/#{resource_name}/#{action}")
        request = Net::HTTP::Post.new(uri)
        request["Authorization"] = "#{config[:token_type]} #{config[:token]}"
        request["Content-type"] = params.delete(:content_type) || "form-data" # 可在 params 中手动配置 content_type
        params = filter_params(params)
        request.set_form(params, "multipart/form-data")
        raw_response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
          http.request(request)
        end

        Response.new(raw_response)
      end

      private

      # 过滤掉值为 nil 的参数，并将键全部转化为 String
      def filter_params(params)
        return {} unless params&.is_a?(Hash)

        params = params.reject { |_, v| v.nil? }
        params.transform_keys(&:to_s)
      end

      # 根据类名获取资源名
      def resource_name
        self.class.name.demodulize.underscore.dasherize
      end

      # 根据调用此方法的方法名，获取对应的接口名
      def action_name
        call_stack = caller(2..2)&.first
        call_stack[/`.*'/][1..-2]&.dasherize
      end
    end
  end
end
