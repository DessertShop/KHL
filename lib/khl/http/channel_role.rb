# frozen_string_literal: true

require_relative "base"

module KHL
  module HTTP
    # 频道角色权限相关接口
    # https://developer.kaiheila.cn/doc/http/channel
    class ChannelRole < Base
      # 频道角色权限详情
      # @param [String] channel_id 频道 ID
      # @return [KHL::HTTP::Response]
      def index(channel_id)
        get(channel_id: channel_id)
      end

      # 创建频道角色权限
      # @param [String] channel_id 频道 ID，如果频道是分组的 ID，会同步给所有 sync=1 的子频道
      # @param [Hash] options
      # @option options [String] :type value 的类型，只能为 "role_id"，"user_id"，不传则默认为 "user_id"
      # @option options [String] :value 根据 type 的值，为 用户 ID 或 频道 ID
      # @return [KHL::HTTP::Response]
      def create(channel_id, options = {})
        post(options.merge(channel_id: channel_id))
      end

      # 更新频道角色权限
      # @param [String] channel_id 频道 ID，如果频道是分组的 ID，会同步给所有 sync=1 的子频道
      # @param [Hash] options
      # @option options [String] :type value 的类型，只能为 "role_id"，"user_id"，不传则默认为 "user_id"
      # @option options [String] :value 根据 type 的值，为 用户 ID 或 频道 ID
      # @option options [Integer] :allow 默认为 0，想要设置的允许的权限值
      # @option options [Integer] :deny 默认为 0，想要设置的拒绝的权限值
      # @return [KHL::HTTP::Response]
      def update(channel_id, options = {})
        post(options.merge(channel_id: channel_id))
      end

      # 删除频道角色权限
      # @param [String] channel_id 频道 ID，如果频道是分组的 ID，会同步给所有 sync=1 的子频道
      # @param [Hash] options
      # @option options [String] :type value 的类型，只能为 "role_id"，"user_id"，不传则默认为 "user_id"
      # @option options [String] :value 根据 type 的值，为用户 ID 或频道 ID
      # @return [KHL::HTTP::Response]
      def delete(channel_id, options = {})
        post(options.merge(channel_id: channel_id))
      end
    end
  end
end
