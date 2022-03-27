# frozen_string_literal: true

require_relative "asset"
require_relative "badge"
require_relative "blacklist"
require_relative "channel"
require_relative "channel_role"
require_relative "channel_user"
require_relative "direct_message"
require_relative "game"
require_relative "gateway"
require_relative "guild"
require_relative "guild_emoji"
require_relative "guild_mute"
require_relative "guild_role"
require_relative "intimacy"
require_relative "invite"
require_relative "message"
require_relative "user"
require_relative "user_chat"

module KHL
  module HTTP
    # Client for the KHL HTTP API
    # @example
    # client = KHL::HTTP::Client.new(token: "bot_token")
    # client.guild.list # Call guild/list API
    class Client
      attr_reader :asset,
        :badge,
        :blacklist,
        :channel,
        :channel_role,
        :channel_user,
        :direct_message,
        :game,
        :gateway,
        :guild,
        :guild_emoji,
        :guild_mute,
        :guild_role,
        :intimacy,
        :invite,
        :message,
        :user,
        :user_chat

      # @param config [Hash] Config
      # @option config [String] :token Bot token (required)
      # @option config [String] :token_type Token type
      # @option config [String] :language Language
      def initialize(config = {})
        raise ArgumentError, "missing token" unless config[:token]
        config[:token_type] ||= "Bot"
        config[:language] ||= "zh-cn"

        @asset = Asset.new(config)
        @badge = Badge.new(config)
        @blacklist = Blacklist.new(config)
        @channel = Channel.new(config)
        @channel_role = ChannelRole.new(config)
        @channel_user = ChannelUser.new(config)
        @direct_message = DirectMessage.new(config)
        @game = Game.new(config)
        @gateway = Gateway.new(config)
        @guild = Guild.new(config)
        @guild_emoji = GuildEmoji.new(config)
        @guild_mute = GuildMute.new(config)
        @guild_role = GuildRole.new(config)
        @intimacy = Intimacy.new(config)
        @invite = Invite.new(config)
        @message = Message.new(config)
        @user = User.new(config)
        @user_chat = UserChat.new(config)
      end
    end
  end
end
