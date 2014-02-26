require 'net/http'

desc 'Call /refresh on main app to flush the cache'
task :update_status do
  print 'Refreshing... '
  res = Net::HTTP.get('mr-spaceapi.herokuapp.com', '/refresh')
  puts res
end
