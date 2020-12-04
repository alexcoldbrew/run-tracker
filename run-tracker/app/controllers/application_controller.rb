require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    # set :show_exceptions, false
  end

  not_found do
    status 404
    erb :error
  end

  get '/runs/new' do
      erb :new
  end

  get "/" do
    erb :index
  end

  get '/runs' do
    if logged_in?
      @runs = current_user.runs
      erb :show
    else
      redirect '/login'
    end
  end

  post '/runs' do
    
    @runs = current_user.runs
    @run = Run.new(params)
    @run.user_id = session[:user_id]
    @run.save
    erb :show
  end

  post '/runs/new' do
    if logged_in?
      @run = Run.new(params)
      @run.user_id = session[:user_id]
      @run.save
      erb :show
    else
      redirect to '/login'
    end
  end

  get '/runs/:id' do
    if logged_in?
      @run = Run.find_by_id(params[:id])
      erb :show
    else
      redirect to '/login'
    end
  end

  get '/runs/:id/edit' do
    @run = Run.find_by_id(params[:id])
    if logged_in?
      erb :edit
    else
      redirect to '/login'
    end
  end

  patch '/runs/:id' do
    @run = Run.find_by_id(params[:id])
    if logged_in?
      @run.date = params[:date]
      @run.distance = params[:distance]
      @run.hours = params[:hours]
      @run.minutes = params[:minutes]
      @run.seconds = params[:seconds]
      @run.save
      redirect to '/runs'
    else
      redirect to '/login'
    end
  end

  delete '/runs/:id/delete' do
    @run = Run.find_by_id(params[:id])
    if logged_in?
      @run.destroy
    end
    redirect to '/runs'
  end

##############################

  get '/login' do
      erb :login
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user != nil && @user.password == params[:password]
      session[:user_id] = @user.id
      redirect to '/runs'
    else
      redirect to '/login'
    end
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password_digest].empty?
      redirect to :signup
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password_digest])
      session[:id] = @user.id
      redirect to '/runs'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end

###############################

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @user ||= User.find(session[:user_id]) 
    end
  end

  # error ActiveRecord::RecordNotFound do
  #   erb :error
  # end

end
