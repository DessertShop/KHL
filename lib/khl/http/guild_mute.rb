# frozen_string_literal: true

require_relative "base"

module KHL
  module HTTP
    # 服务器静音闭麦相关接口
    # https://developer.kaiheila.cn/doc/http/guild
    class GuildMute < Base
      # 服务器静音闭麦列表
      # @param [String] guild_id 服务器 ID
      # @param [Hash] options 可选参数
      # @option options [String] :return_type 返回格式，建议为 "detail", 其他情况仅作为兼容
      # @return [KHL::HTTP::Response]
      def list(guild_id, options = {})
        get(options.merge(guild_id: guild_id))
      end

      # 添加服务器静音或闭麦
      # @param [String] guild_id 服务器 ID
      # @param [String] user_id 用户 ID
      # @param [Integer] type 静音类型，1 代表麦克风闭麦，2 代表耳机静音
      # @return [KHL::HTTP::Response]
      def create(guild_id, user_id, type)
        post(guild_id: guild_id, user_id: user_id, type: type)
      end

      # 删除服务器静音或闭麦
      # @param [String] guild_id 服务器 ID
      # @param [String] user_id 用户 ID
      # @param [Integer] type 静音类型，1 代表麦克风闭麦，2 代表耳机静音
      # @return [KHL::HTTP::Response]
      def delete(guild_id, user_id, type)
        post(guild_id: guild_id, user_id: user_id, type: type)
      end
    end
  end
end
