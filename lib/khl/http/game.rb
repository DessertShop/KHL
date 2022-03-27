# frozen_string_literal: true

require_relative "base"

module KHL
  module HTTP
    # 用户动态相关接口-游戏/进程/音乐
    # https://developer.kaiheila.cn/doc/http/game
    class Game < Base
      # 游戏列表
      # @return [KHL::HTTP::Response]
      def list
        get(action: nil)
      end

      # 添加游戏
      # @note 本接口有数据插入频率限制，单日最大可创建 5 个游戏数据
      # @param [String] name 名称
      # @param [Hash] options 可选参数
      # @option options [String] :process_name 进程名
      # @option options [String] :icon 图标
      # @return [KHL::HTTP::Response]
      def create(name, options = {})
        post(options.merge(name: name))
      end

      # 更新游戏
      # @param [Integer] id	ID
      # @param [Hash] options 可选参数
      # @option options [String] :name 名称
      # @option options [String] :icon 图标
      # @return [KHL::HTTP::Response]
      def update(id, options = {})
        post(options.merge(id: id))
      end

      # 删除游戏
      # @param [Integer] id	ID
      # @return [KHL::HTTP::Response]
      def delete(id)
        post(id: id)
      end

      # 添加游戏记录-开始玩
      # @param [Integer] id	游戏 ID
      # @param [Integer] data_type 请求数据类型，固定传 1（游戏）
      # @return [KHL::HTTP::Response]
      def activity(id, data_type)
        post(id: id, data_type: data_type)
      end

      # 删除游戏记录-结束玩
      # @return [KHL::HTTP::Response]
      def delete_activity
        post
      end
    end
  end
end
