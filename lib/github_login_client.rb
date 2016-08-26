require 'json'
require 'faraday'
class GH_Client
  def initialize(username,pass)
    @faraday = Faraday.new(:url => 'https://api.github.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      # faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      faraday.basic_auth(username,pass)
    end
  end

  def test_login
    @faraday.get('/users').status == 200
  end

  def get_languages(username)
    JSON.parse(@faraday.get("/users/#{username}/repos").body).map {|r|r["full_name"]}.
      inject({}) do |res,f_name|
        JSON.parse(@faraday.get("/repos/#{f_name}/languages").body).each do |lang,amount|
          res[lang] = res.fetch(lang,0) + amount
        end
        res
      end
  end

end
