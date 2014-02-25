require 'lib/door'
require 'json'

class App < Sinatra::Base
  register Sinatra::CrossOrigin

  configure do
    enable :cross_origin

    set :redis_json_cache_key, 'cache/status.json'
    redis_uri = URI.parse(ENV["REDISTOGO_URL"] || 'redis://localhost:6379')
    REDIS = Redis.new(host: redis_uri.host, port: redis_uri.port, password: redis_uri.password)
  end

  before do
    cache_control :no_cache
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  get '/' do
    content_type :text
    send_file 'views/index.md'
  end

  get '/status.json' do
    content_type :json
    res = REDIS.get(settings.redis_json_cache_key)
    res || flush_cache
  end

  get '/refresh' do
    content_type :text
    begin
      flush_cache
      'OK'
    rescue Twitter::Error::Forbidden
      'Bad Twitter credentials'
    end
  end

  def flush_cache
    json = Door.new.status.to_json
    REDIS.set(settings.redis_json_cache_key, json)
    json
  end
end
