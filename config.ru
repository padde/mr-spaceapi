$:.unshift File.expand_path(File.dirname(__FILE__))

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

Twitter.configure do |config|
  config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
  config.oauth_token        = ENV['TWITTER_OAUTH_TOKEN']
  config.oauth_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
end

require 'app'

run App.new
