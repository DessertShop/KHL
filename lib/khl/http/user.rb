# frozen_string_literal: true

require_relative "base"

module KHL
  module HTTP
    # 用户相关接口
    # https://developer.kaiheila.cn/doc/http/user
    class User < Base
      # 获取当前用户信息
      # @return [KHL::HTTP::Response]
      def me
        get
      end

      # 获取目标用户信息
      # @param [String] user_id 用户 ID
      # @param [Hash] options 可选参数
      # @option options [String] :guild_id 服务器 ID
      # @return [KHL::HTTP::Response]
      def view(user_id, options = {})
        get(options.merge(user_id: user_id))
      end

      # 下线机器人
      # @return [KHL::HTTP::Response]
      def offline
        post
      end
    end
  end
end
