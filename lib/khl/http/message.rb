# frozen_string_literal: true

require_relative "base"

module KHL
  module HTTP
    # 频道消息相关接口
    # https://developer.kaiheila.cn/doc/http/message
    class Message < Base
      # 获取频道聊天消息列表
      # @note 此接口非标准分页，需要根据参考消息来查询相邻分页的消息
      # @param [String] target_id 频道 ID
      # @param [Hash] options 可选参数
      # @option options [String] :msg_id 参考消息 ID，不传则查询最新消息
      # @option options [Integer] :pin 只能为 0 或者 1，是否查询置顶消息。置顶消息只支持查询最新的消息
      # @option options [String] :flag 查询模式，有三种模式可以选择 before、around、after。不传则默认查询最新的消息
      # @option options [Integer] :page_size 当前分页消息数量，默认 50
      # @return [KHL::HTTP::Response]
      def list(target_id, options = {})
        get(options.merge(target_id: target_id))
      end

      # 获取频道聊天消息详情
      # @param [String] msg_id 消息 ID
      # @return [KHL::HTTP::Response]
      def view(msg_id)
        get(msg_id: msg_id)
      end

      # 发送频道聊天消息
      # @note 此接口与频道相关接口下的 "发送频道聊天消息" 功能相同
      # @warning 强列建议过滤掉机器人发送的消息，再进行回应。否则会很容易形成两个机器人循环自言自语导致发送量过大，进而导致机器人被封禁。如果确实需要机器人联动的情况，慎重进行处理，防止形成循环
      # @param [String] target_id 频道 ID
      # @param [String] content 消息内容
      # @param [Hash] options 可选参数
      # @option options [Integer] :type 消息类型，不传默认为 1，代表文本类型。9 代表 kmarkdown 消息，10 代表卡片消息
      # @option options [String] :quote 回复某条消息的 msg_id
      # @option options [String] :nonce 随机字符串，服务端不做处理，原样返回
      # @option options [String] :temp_target_id 用户 ID，如果传了，代表该消息是临时消息，该消息不会存数据库，但是会在频道内只给该用户推送临时消息。用于在频道内针对用户的操作进行单独的回应通知等
      # @return [KHL::HTTP::Response]
      def create(target_id, content, options = {})
        post(options.merge(target_id: target_id, content: content))
      end

      # 更新频道聊天消息
      # @note 目前支持消息 type 为 9、10 的修改，即 KMarkdown 和 CardMessage
      # @param [String] msg_id 消息 ID
      # @param [String] content 消息内容
      # @param [Hash] options 可选参数
      # @option options [String] :quote 回复某条消息的 msg_id。如果为空，则代表删除回复，不传则无影响
      # @option options [String] :temp_target_id 用户 ID，针对特定用户临时更新消息，必须是正常消息才能更新。与发送临时消息概念不同，但同样不保存数据库
      # @return [KHL::HTTP::Response]
      def update(msg_id, content, options = {})
        post(options.merge(msg_id: msg_id, content: content))
      end

      # 删除频道聊天消息
      # @note 普通用户只能删除自己的消息，有权限的用户可以删除权限范围内他人的消息
      # @param [String] msg_id 消息 ID
      # @return [KHL::HTTP::Response]
      def delete(msg_id)
        post(msg_id: msg_id)
      end

      # 获取频道消息某回应的用户列表
      # @param [String] msg_id 频道消息 ID
      # @param [String] emoji Emoji ID，可以为 GuilEmoji 或者 Emoji，注意：在 GET 中，应该进行 urlencode
      # @return [KHL::HTTP::Response]
      def reaction_list(msg_id, emoji)
        get(msg_id: msg_id, emoji: emoji)
      end

      # 给某个消息添加回应
      # @param [String] msg_id 频道消息 ID
      # @param [String] emoji Emoji ID，可以为 GuilEmoji 或者 Emoji，注意：在 GET 中，应该进行 urlencode
      # @return [KHL::HTTP::Response]
      def add_reaction(msg_id, emoji)
        post(msg_id: msg_id, emoji: emoji)
      end

      # 删除消息的某个回应
      # @param [String] msg_id 频道消息 ID
      # @param [String] emoji Emoji ID，可以为 GuilEmoji 或者 Emoji，注意：在 GET 中，应该进行 urlencode
      # @param [Hash] options 可选参数
      # @option options [String] :user_id 用户 ID, 如果不填则为自己的 ID。删除别人的回应需要有管理频道消息的权限
      # @return [KHL::HTTP::Response]
      def delete_reaction(msg_id, emoji, options = {})
        post(options.merge(msg_id: msg_id, emoji: emoji))
      end
    end
  end
end
