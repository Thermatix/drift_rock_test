file = __FILE__
[File.dirname(file),File.expand_path('../lib', file)].each do |dir|
  $LOAD_PATH.unshift dir unless $LOAD_PATH.include?(dir)
end
require 'github_login_client'
require 'session_store'

require 'app'

use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :secret => Digest::SHA1.hexdigest(rand.to_s)

run App
