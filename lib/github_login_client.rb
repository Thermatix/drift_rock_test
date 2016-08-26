require 'json'
require 'faraday'
class GH_Client
  def initialize(username,pass)
    @faraday = Faraday.new(:url => 'https://api.github.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      faraday.basic_auth(username,pass)
    end
  end

  def test_login
    @faraday.get('/users').status == 200
  end

  def get_data('username')
    @faraday.get()
  end

end
