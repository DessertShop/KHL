# frozen_string_literal: true

require "active_support/core_ext/hash/indifferent_access"
require "active_support/hash_with_indifferent_access"

require_relative "event"

module KHL
  class Message
    TYPES = %i[
      event
      hello
      ping
      pong
      resume
      reconnect
      resume_ack
    ].freeze

    attr_accessor :type, :data, :sn

    def self.parse(raw)
      return unless raw

      data = raw.is_a?(String) ? JSON.parse(raw) : raw
      data = ActiveSupport::HashWithIndifferentAccess.new(data)

      Message.new(
        type: TYPES[data[:s]],
        data: data[:d],
        sn: data[:sn]
      )
    end

    def initialize(type: nil, data: nil, sn: nil)
      @type = type
      @data = data
      @sn = sn
    end

    def event
      return unless event?

      Event.new(@data)
    end

    def to_h
      ActiveSupport::HashWithIndifferentAccess.new(
        s: TYPES.index(type),
        d: data,
        sn: sn
      )
    end

    def to_json
      to_h.to_json
    end

    TYPES.each do |type|
      define_method("#{type}?") do
        @type == type
      end
    end
  end
end
