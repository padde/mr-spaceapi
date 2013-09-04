require 'lib/door'
require 'json'

class App < Sinatra::Base
  register Sinatra::CrossOrigin

  configure do
    set :redis_json_cache_key, 'cache/api/v0_12/status.json'
    redis_uri = URI.parse(ENV["REDISTOGO_URL"] || 'redis://localhost:6379')
    REDIS = Redis.new(host: redis_uri.host, port: redis_uri.port, password: redis_uri.password)
  end

  get '/' do
    content_type :text
    send_file 'views/index.md'
  end

  get '/api/v0_12/status.json' do
    content_type :json
    cross_origin
    res = REDIS.get(settings.redis_json_cache_key)
    res || flush_cache
  end

  get '/api/v0_12/update_status' do
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
