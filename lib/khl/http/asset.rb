# frozen_string_literal: true

require_relative "base"

module KHL
  module HTTP
    # 媒体相关接口
    # https://developer.kaiheila.cn/doc/http/asset
    class Asset < Base
      # 上传媒体文件
      # @param [Hash] options 可选参数
      # @option options [IO] :file 目前支持 图片，视频（.mp4 .mov），文件
      # @return [KHL::HTTP::Response]
      def create(options = {})
        post_file(options)
      end
    end
  end
end
