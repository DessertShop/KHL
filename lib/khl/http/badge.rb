# frozen_string_literal: true

require_relative "base"

module KHL
  module HTTP
    # 徽章相关接口
    # https://developer.kaiheila.cn/doc/http/badge
    class Badge < Base
      # 获取服务器徽章
      # @param [String] guild_id 服务器 ID
      # @param [Hash] options 可选参数
      # @option options [Integer] :style 样式类型，默认为 0
      # @return [KHL::HTTP::Response]
      def guild(guild_id, options = {})
        get(options.merge(guild_id: guild_id))
      end
    end
  end
end
