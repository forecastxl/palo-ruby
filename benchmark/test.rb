require '../lib/palo'
require 'benchmark'

include Benchmark

session = Palo::Session.new("127.0.0.1", "7777", "admin", "admin")
puts "Valid session: #{session.is_valid_session?}"

# p session.server.databases
# p session.sid
url = "#{session.base_url}/server/databases?sid=#{session.sid}"
p url
# p `ab -n 10 -c 2 #{url}`

n = 1000
Benchmark.bm(20) do |x|
  x.report('server/databases') do
    n.times do
      session.server.databases
    end
  end
end
