# frozen_string_literal: true

require_relative "base"

module KHL
  module HTTP
    # 黑名单相关接口
    # https://developer.kaiheila.cn/doc/http/blacklist
    class Blacklist < Base
      # 获取黑名单列表
      # @param [String] guild_id 服务器 ID
      # @param [Hash] options 可选参数
      # @option options [Integer] :page 页数
      # @option options [Integer] :page_size 每页数据数量
      # @option options [String] :sort 代表排序的字段，比如 -id 代表 id 按 DESC 排序，id 代表 id 按 ASC 排序
      # @return [KHL::HTTP::Response]
      def list(guild_id, options = {})
        get(options.merge(guild_id: guild_id))
      end

      # 加入黑名单
      # @param [String] guild_id 服务器 ID
      # @param [String] target_id 用户 ID
      # @param [Hash] options 可选参数
      # @option options [String] :remark 加入黑名单的原因
      # @option options [Integer] :del_msg_days 删除最近几天的消息，最大 7 天，默认 0
      # @return [KHL::HTTP::Response]
      def create(guild_id, target_id, options = {})
        post(options.merge(guild_id: guild_id, target_id: target_id))
      end

      # 移除黑名单
      # @param [String] guild_id 服务器 ID
      # @param [String] target_id 用户 ID
      # @return [KHL::HTTP::Response]
      def delete(guild_id, target_id)
        post(guild_id: guild_id, target_id: target_id)
      end
    end
  end
end
