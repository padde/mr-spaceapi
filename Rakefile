desc 'Call /api/v0_12/update_status on main app to flush the cache'
task :update_status do
  require 'net/http'
  puts 'Requesting update...'
  res = Net::HTTP.get('mr-spaceapi.herokuapp.com', '/api/v0_12/update_status')
  puts "API response: #{res}"
end
