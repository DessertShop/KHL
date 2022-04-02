# frozen_string_literal: true

require "active_support/core_ext/hash/indifferent_access"
require "active_support/hash_with_indifferent_access"

module KHL
  class Event
    attr_accessor :channel_type, :type, :target_id, :author_id, :content, :msg_id, :msg_timestamp, :nonce, :extra

    def initialize(params = {})
      params = ActiveSupport::HashWithIndifferentAccess.new(params)

      @channel_type = params[:channel_type]
      @type = params[:type]
      @target_id = params[:target_id]
      @author_id = params[:author_id]
      @content = params[:content]
      @msg_id = params[:msg_id]
      @msg_timestamp = params[:msg_timestamp]
      @nonce = params[:nonce]
      @extra = params[:extra]
    end
  end
end
