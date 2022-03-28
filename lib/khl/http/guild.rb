# frozen_string_literal: true

require_relative "base"

module KHL
  module HTTP
    # 服务器相关接口
    # https://developer.kaiheila.cn/doc/http/guild
    class Guild < Base
      # 获取当前用户加入的服务器列表
      # @param [Hash] options 可选参数
      # @option options [Integer] :page 页数
      # @option options [Integer] :page_size 每页数据数量
      # @option options [String] :sort 代表排序的字段，比如 -id 代表 id 按 DESC 排序，id 代表 id 按 ASC 排序
      # @return [KHL::HTTP::Response]
      def list(options = {})
        get(options)
      end

      # 获取服务器详情
      # @param [String] guild_id 服务器 ID
      # @return [KHL::HTTP::Response]
      def view(guild_id)
        get(guild_id: guild_id)
      end

      # 获取服务器中的用户列表
      # @param [String] guild_id 服务器 ID
      # @param [Hash] options 可选参数
      # @option options [String] :channel_id 频道 ID
      # @option options [String] :search 搜索关键字，在用户名或昵称中搜索
      # @option options [Integer] :role_id 角色 ID，获取特定角色的用户列表
      # @option options [Integer] :mobile_verified 只能为 0 或 1，0 是未认证，1 是已认证
      # @option options [Integer] :active_time 根据活跃时间排序，0 是顺序排列，1 是倒序排列
      # @option options [Integer] :joined_at 根据加入时间排序，0 是顺序排列，1 是倒序排列
      # @option options [Integer] :page 页数
      # @option options [Integer] :page_size 每页数据数量
      # @option options [String] :filter_user_id 获取指定 ID 所属用户的信息
      # @return [KHL::HTTP::Response]
      def user_list(guild_id, options = {})
        get(options.merge(guild_id: guild_id))
      end

      # 修改服务器中用户的昵称
      # @param [String] guild_id 服务器 ID
      # @param [Hash] options 可选参数
      # @option options [String] :nickname 昵称，2-64 长度，不传则清空昵称
      # @option options [String] :user_id 用户 ID，不传则修改当前登陆用户的昵称
      # @return [KHL::HTTP::Response]
      def nickname(guild_id, options = {})
        post(options.merge(guild_id: guild_id))
      end

      # 离开服务器
      # @param [String] guild_id 服务器 ID
      # @return [KHL::HTTP::Response]
      def leave(guild_id)
        post(guild_id: guild_id)
      end

      # 踢出服务器
      # @param [String] guild_id 服务器 ID
      # @param [String] target_id 用户 ID
      # @return [KHL::HTTP::Response]
      def kickout(guild_id, target_id)
        post(guild_id: guild_id, target_id: target_id)
      end
    end
  end
end
