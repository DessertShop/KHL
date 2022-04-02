# KHL

开黑啦 Ruby SDK

[官方开发者文档](https://developer.kaiheila.cn/doc)

## Prerequisites

* ruby >= 2.7

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'khl'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install khl

## Usage

```
require "khl"

token = "your_bot_token"

# Call HTTP API
http_client = KHL::HTTP::Client.new(token: token)
http_client.guild.list # Call guild/list API

# Connect to WebSocket API
ws_client = KHL::WebSocket::Client.new(token: token)
Thread.new { ws_client.run } # Run WebSocket client
ws_clinet.state # Get current state
ws_client.messages.pop # Get message from queue

# Use Webhook API
webhook_client = KHL::Webhook::Client.new("webhook_url",  "challenge_token")
webhook_client.online? # => false
webhook_client.challenge # Do challenge
webhook_client.online? # => true
webhook_client.parse_message("data from webhook")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, please bump version, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/DessertShop/KHL.
