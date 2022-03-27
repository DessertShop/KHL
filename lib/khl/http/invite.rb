# frozen_string_literal: true

require_relative "base"

module KHL
  module HTTP
    # 邀请相关接口
    # https://developer.kaiheila.cn/doc/http/invite
    class Invite < Base
      # 获取邀请列表
      # @param [Hash] options 可选参数
      # @option options [String] :guild_id 服务器 ID
      # @option options [String] :channel_id 频道 ID
      # @option options [Integer] :page 页数
      # @option options [Integer] :page_size 每页数据数量
      # @return [KHL::HTTP::Response]
      def list(options = {})
        get(options)
      end

      # 创建邀请链接
      # @option options [String] :guild_id 服务器 ID
      # @option options [String] :channel_id 频道 ID
      # @option options [Integer] :duration 邀请链接有效时长（秒），默认 7 天。
      #   可选值： 0（永不）、1800（0.5 小时）、3600（1 小时）、21600（6 小时）、43200（12小时）、86400（1 天）、604800（7 天）
      # @option options [Integer] :setting_times 设置的次数，默认-1。可选值：-1（无限制）、1、5、10、25、50、100
      # @return [KHL::HTTP::Response]
      def create(options = {})
        post(options)
      end

      # 删除邀请链接
      # @param [String] url_code 邀请码
      # @param [Hash] options 可选参数
      # @option options [String] :guild_id 服务器 ID
      # @option options [String] :channel_id 频道 ID
      # @return [KHL::HTTP::Response]
      def delete(url_code, options = {})
        post(options.merge(url_code: url_code))
      end
    end
  end
end
