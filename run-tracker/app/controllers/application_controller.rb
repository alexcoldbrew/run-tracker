require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/runs/new' do
      erb :new
  end

  get "/" do
    redirect to '/runs'
  end

  get '/runs' do
    @runs = Run.all
    erb :index
  end

  get '/login' do
    erb :login
  end



  helpers do
    def logged_in?
      !!session[:user_id]
    end
  end

end
