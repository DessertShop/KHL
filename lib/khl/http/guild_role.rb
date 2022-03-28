# frozen_string_literal: true

require_relative "base"

module KHL
  module HTTP
    # 服务器角色权限相关接口
    # https://developer.kaiheila.cn/doc/http/guild-role
    class GuildRole < Base
      # 获取服务器角色列表
      # @param [String] guild_id 服务器 ID
      # @param [Hash] options 可选参数
      # @option options [Integer] :page 页数
      # @option options [Integer] :page_size 每页数据数量
      # @return [KHL::HTTP::Response]
      def list(guild_id, options = {})
        get(options.merge(guild_id: guild_id))
      end

      # 创建服务器角色
      # @param [String] guild_id 服务器 ID
      # @param [Hash] options 可选参数
      # @option options [String] :name 角色名称，如果不写，则为 "新角色"
      # @return [KHL::HTTP::Response]
      def create(guild_id, options = {})
        post(options.merge(guild_id: guild_id))
      end

      # 更新服务器角色
      # @param [String] guild_id 服务器 ID
      # @param [Integer] role_id 角色 ID
      # @param [Hash] options 可选参数
      # @option options [String] :name 角色名称
      # @option options [Integer] :color 颜色
      # @option options [Integer] :hoist 只能为 0 或者 1，是否把该角色的用户在用户列表排到前面
      # @option options [Integer] :mentionable 只能为 0 或者 1，该角色是否可以被提及
      # @option options [Integer] :permissions 权限
      # @return [KHL::HTTP::Response]
      def update(guild_id, role_id, options = {})
        post(options.merge(guild_id: guild_id, role_id: role_id))
      end

      # 删除服务器角色
      # @param [String] guild_id 服务器 ID
      # @param [Integer] role_id 角色 ID
      # @return [KHL::HTTP::Response]
      def delete(guild_id, role_id)
        post(guild_id: guild_id, role_id: role_id)
      end

      # 赋予用户角色
      # @param [String] guild_id 服务器 ID
      # @param [String] user_id 用户 ID
      # @param [Integer] role_id 角色 ID
      # @return [KHL::HTTP::Response]
      def grant(guild_id, user_id, role_id)
        post(guild_id: guild_id, user_id: user_id, role_id: role_id)
      end

      # 删除用户角色
      # @param [String] guild_id 服务器 ID
      # @param [String] user_id 用户 ID
      # @param [Integer] role_id 角色 ID
      # @return [KHL::HTTP::Response]
      def revoke(guild_id, user_id, role_id)
        post(guild_id: guild_id, user_id: user_id, role_id: role_id)
      end
    end
  end
end
