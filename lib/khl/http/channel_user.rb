# frozen_string_literal: true

require_relative "base"

module KHL
  module HTTP
    # 频道用户相关接口
    # https://developer.kaiheila.cn/doc/http/channel-user
    class ChannelUser < Base
      # 根据用户 ID 和服务器 ID 获取用户所在语音频道
      # @param [String] guild_id 服务器 ID
      # @param [String] user_id 用户 ID
      # @param [Hash] options 可选参数
      # @option options [Integer] :page 页数
      # @option options [Integer] :page_size 每页数据数量
      # @return [KHL::HTTP::Response]
      def get_joined_channel(guild_id, user_id, options = {})
        get(options.merge(guild_id: guild_id, user_id: user_id))
      end
    end
  end
end
