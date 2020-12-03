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
    @runs = Run.all
    erb :index
  end

  get '/runs' do
    @runs = Run.all
    erb :show
  end

  post '/runs' do
    Run.create(params)
    erb :show
  end

  post '/runs/new' do
    if logged_in?
      @run = Run.new(params)
      @run.user_id = session[:user_id]
      @run.save
    else
      redirect to '/login'
    end
  end

  get '/runs/:id' do
    if logged_in?
      @run - Run.find_by_id(params[:id])
      erb :show
    else
      redirect to '/login'
    end
  end

  get '/runs/:id/edit' do
    @run = Run.find_by_id(params[:id])
    if logged_in? # && @run.user[:id] == session[:user_id]
      erb :edit
    else
      redirect to '/login'
    end
  end

  patch '/runs/:id/edit' do
    @run = Run.find_by_id(params[:id])
    if logged_in? && @run.user[:id] == session[:user_id]
      @run.date = params[:date]
      @run.distance = params[:distance]
      @run.hours = params[:hours]
      @run.minutes = params[:minutes]
      @run.seconds = params[:seconds]
      @run.save
    else
      redirect to '/login'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/runs'
    else
      erb :login
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user # && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/runs'
    else
      redirect to '/login'
    end
  end

  get '/signup' do
    if session[:id] == nil
      erb :signup
    else
      redirect to '/runs'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to :signup
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:id] = @user.id
      redirect to '/runs'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end



  helpers do
    def logged_in?
      !!session[:user_id]
    end
  end

end
