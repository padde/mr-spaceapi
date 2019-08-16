$:.unshift File.expand_path(File.dirname(__FILE__))

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

TWITTER_CLIENT = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
  config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
  config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
end

require 'app'

run App.new
