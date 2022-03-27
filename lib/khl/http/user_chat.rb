# frozen_string_literal: true

require_relative "base"

module KHL
  module HTTP
    # 私信聊天会话相关接口
    # https://developer.kaiheila.cn/doc/http/user-chat
    class UserChat < Base
      # 获取私信聊天会话列表
      # @param [Hash] options 可选参数
      # @option options [Integer] :page 页数
      # @option options [Integer] :page_size 每页数据数量
      # @return [KHL::HTTP::Response]
      def list(options = {})
        get(options)
      end

      # 获取私信聊天会话详情
      # @param [String] chat_code 私聊会话 Code
      # @return [KHL::HTTP::Response]
      def view(chat_code)
        get(chat_code: chat_code)
      end

      # 创建私信聊天会话
      # @param [String] target_id 用户 ID
      # @return [KHL::HTTP::Response]
      def create(target_id)
        post(target_id: target_id)
      end

      # 删除私信聊天会话
      # @note 只能删除自己的消息
      # @param [String] target_id 用户 ID
      # @return [KHL::HTTP::Response]
      def delete(target_id)
        post(target_id: target_id)
      end
    end
  end
end
