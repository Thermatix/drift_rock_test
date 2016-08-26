require 'sinatra'
require 'pry'
class App < Sinatra::Base
  set :root, File.dirname(__FILE__)

  get '/' do
    check_for_git_api_key
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    if  GH_Client.new(params['username'],params['password']).test_login
      session['username'] = params['username']
      session['password'] = params['password']
      redirect to('/search'),303
    else
      redirect to('/login'),303

    end
  end

  get '/search' do
    erb :search
  end

  post '/search'do
    check_for_git_api_key
    @res = GH_Client.new(session['username'],session['password']).get_data(params['username'])
    erb :search
  end

  get '/logout' do
    session['username'] = nil
    session['password'] = nil
    check_for_git_api_key
  end

  def check_for_git_api_key
    if session['username']
     redirect to('/search')
    else
     redirect to('/login')
    end
  end
end
