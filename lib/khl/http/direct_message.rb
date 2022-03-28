# frozen_string_literal: true

require_relative "base"

module KHL
  module HTTP
    # 用户私聊消息相关接口
    # https://developer.kaiheila.cn/doc/http/direct-message
    class DirectMessage < Base
      # 获取私信聊天消息列表
      # @note 此接口非标准分页，需要根据参考消息来查询相邻分页的消息
      # @param [Hash] options 可选参数
      # @option options [String] :target_id 用户 ID，后端会自动创建会话。有此参数之后可不传 chat_code 参数
      # @option options [String] :chat_code 会话 Code。chat_code 与 target_id 必须传一个
      # @option options [String] :msg_id 消息 ID，不传则查询最新消息
      # @option options [String] :flag 查询模式，有三种模式可以选择 before、around、after。不传则默认查询最新的消息
      # @option options [Integer] :page 页数
      # @option options [Integer] :page_size 当前分页消息数量，默认 50
      # @return [KHL::HTTP::Response]
      def list(options = {})
        get(options)
      end

      # 发送私信聊天消息
      # @param [String] content 消息内容
      # @param [Hash] options 可选参数
      # @option options [Integer] :type	消息类型，不传默认为 1，代表文本类型。9 代表 kmarkdown 消息，10 代表卡片消息
      # @option options [String] :target_id 用户 ID，后端会自动创建会话。有此参数之后可不传 chat_code 参数
      # @option options [String] :chat_code 会话 Code。chat_code 与 target_id 必须传一个
      # @option options [String] :quote 回复某条消息的 msg_id
      # @option options [String] :nonce 随机字符串，服务端不做处理, 原样返回
      # @return [KHL::HTTP::Response]
      def create(content, options = {})
        post(options.merge(content: content))
      end

      # 更新私信聊天消息
      # @note 目前支持消息 type 为 9、10 的修改，即 KMarkdown 和 CardMessage
      # @param [String] content 消息内容
      # @param [Hash] options 可选参数
      # @option options [String] :msg_id 消息 ID
      # @option options [String] :quote 回复某条消息的 msg_id。如果为空，则代表删除回复，不传则无影响
      # @return [KHL::HTTP::Response]
      def update(content, options = {})
        post(options.merge(content: content))
      end

      # 删除私信聊天消息
      # @note 只能删除自己的消息
      # @param [Hash] options 可选参数
      # @option options [String] :msg_id 消息 ID
      # @return [KHL::HTTP::Response]
      def delete(options = {})
        post(options)
      end

      # 获取频道消息某回应的用户列表
      # @param [String] msg_id 消息 ID
      # @param [Hash] options 可选参数
      # @option options [String] :emoji Emoji ID，可以为 GuildEmoji 或者 Emoji，注意：在 GET 中，应该进行 urlencode
      # @return [KHL::HTTP::Response]
      def reaction_list(msg_id, options = {})
        get(options.merge(msg_id: msg_id))
      end

      # 给某个消息添加回应
      # @param [String] msg_id 消息 ID
      # @param [String] emoji Emoji ID，可以为 GuildEmoji 或者 Emoji，注意：在 GET 中，应该进行 urlencode
      # @return [KHL::HTTP::Response]
      def add_reaction(msg_id, emoji)
        post(msg_id: msg_id, emoji: emoji)
      end

      # 删除消息的某个回应
      # @param [String] msg_id 消息 ID
      # @param [String] emoji Emoji ID，可以为 GuildEmoji 或者 Emoji，注意：在 GET 中，应该进行 urlencode
      # @param [Hash] options 可选参数
      # @option options [String] :user_id 用户 ID，如果不填则为自己的 ID。删除别人的回应需要有管理频道消息的权限
      # @return [KHL::HTTP::Response]
      def delete_reaction(msg_id, emoji, options = {})
        post(options.merge(msg_id: msg_id, emoji: emoji))
      end
    end
  end
end
