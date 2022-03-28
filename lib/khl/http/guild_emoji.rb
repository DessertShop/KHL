# frozen_string_literal: true

require_relative "base"

module KHL
  module HTTP
    # 服务器表情相关接口
    # https://developer.kaiheila.cn/doc/http/guild-emoji
    class GuildEmoji < Base
      # 获取服务器表情列表
      # @param [String] guild_id 服务器 ID
      # @param [Hash] options 可选参数
      # @option options [Integer] :page 页数
      # @option options [Integer] :page_size 每页数据数量
      # @return [KHL::HTTP::Response]
      def list(guild_id, options = {})
        get(options.merge(guild_id: guild_id))
      end

      # 创建服务器表情
      # @param [String] guild_id 服务器 ID
      # @param [IO] emoji 表情文件。必须为 PNG 类型，大小不能超过 256 KB
      # @param [Hash] options 可选参数
      # @option options [String] :name 表情名。长度限制 2-32 字符，如果不写，则为随机字符串
      # @return [KHL::HTTP::Response]
      def create(guild_id, emoji, options = {})
        post_file(options.merge(content_type: "multipart/form-data", guild_id: guild_id, emoji: emoji))
      end

      # 更新服务器表情
      # @param [String] name 表情名。长度限制 2-32 字符，如果不写，则为随机字符串
      # @param [String] id 表情 ID
      # @return [KHL::HTTP::Response]
      def update(name, id)
        post(name: name, id: id)
      end

      # 删除服务器表情
      # @param [String] id 表情 ID
      # @return [KHL::HTTP::Response]
      def delete(id)
        post(id: id)
      end
    end
  end
end
