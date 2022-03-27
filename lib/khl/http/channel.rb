# frozen_string_literal: true

require_relative "base"

module KHL
  module HTTP
    # 频道相关接口
    # https://developer.kaiheila.cn/doc/http/channel
    class Channel < Base
      # 获取频道列表
      # @param [String] guild_id 服务器 ID
      # @param [Hash] options 可选参数
      # @option options [Integer] :page 页数
      # @option options [Integer] :page_size 每页数据数量
      # @option options [Integer] :type 频道类型，1 为文字，2 为语音，默认为 1
      # @return [KHL::HTTP::Response]
      def list(guild_id, options = {})
        get(options.merge(guild_id: guild_id))
      end

      # 获取频道详情
      # @param [String] target_id 频道 ID
      # @return [KHL::HTTP::Response]
      def view(target_id)
        get(target_id: target_id)
      end

      # 创建频道
      # @param [String] guild_id 服务器 ID
      # @param [String] name 频道名称
      # @param [Hash] options 可选参数
      # @option options [String] :parent_id 父分组 ID
      # @option options [Integer] :type 频道类型，1 文字，2 语音，默认为 1
      # @option options [Integer] :limit_amount 语音频道人数限制，最大 99
      # @option options [Integer] :voice_quality 语音音质，默认为 2。1 流畅，2 正常，3 高质量
      # @return [KHL::HTTP::Response]
      def create(guild_id, name, options = {})
        post(options.merge(guild_id: guild_id, name: name))
      end

      # 删除频道
      # @param [String] channel_id 频道 ID
      # @return [KHL::HTTP::Response]
      def delete(channel_id)
        post(channel_id: channel_id)
      end

      # 语音频道之间移动用户
      # @note 只能在语音频道之间移动，用户也必须在其他语音频道在线才能够移动到目标频道
      # @param [String] target_id 频道 ID，需要是语音频道
      # @param [Array] user_ids 用户 ID 数组
      # @return [KHL::HTTP::Response]
      def move_user(target_id, user_ids)
        post(target_id: target_id, user_ids: user_ids)
      end
    end
  end
end
