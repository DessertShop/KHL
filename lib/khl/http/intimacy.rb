# frozen_string_literal: true

require_relative "base"

module KHL
  module HTTP
    # 亲密度相关接口
    # https://developer.kaiheila.cn/doc/http/intimacy
    class Intimacy < Base
      # 获取用户亲密度
      # @param [String] user_id 用户 ID
      # @return [KHL::HTTP::Response]
      def index(user_id)
        get(user_id: user_id)
      end

      # 更新用户亲密度
      # @param [String] user_id 用户 ID
      # @param [Hash] options 可选参数
      # @option options [Integer] :score 亲密度，0-2200
      # @option options [String] :social_info 机器人与用户的社交信息，500 字以内
      # @option options [String] :img_id 表情 ID
      # @return [KHL::HTTP::Response]
      def update(user_id, options = {})
        post(options.merge(user_id: user_id))
      end
    end
  end
end
