# frozen_string_literal: true

require_relative "base"

module KHL
  module HTTP
    # 网关相关接口
    # https://developer.kaiheila.cn/doc/http/gateway
    class Gateway < Base
      # 获取网关连接地址
      # @param [Hash] options 可选参数
      # @option options [Integer] :compress 下发数据是否压缩，默认为 1，代表压缩
      # @return [KHL::HTTP::Response]
      def index(options = {})
        get(options)
      end
    end
  end
end
