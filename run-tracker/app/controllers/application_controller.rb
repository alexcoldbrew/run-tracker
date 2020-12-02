require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end

  # CREATE

  get '/runs/new' do
    erb :new
  end

  get '/runs' do
    @runs = Run.all
    erb :index
  end

  # CREATE

  post '/runs' do
    @run = Run.create(:time => params[:time], :distance => params[:distance], :hours => params[:hours], :minutes => params[:minutes], :seconds => params[:seconds])
    redirect to "/runs/#{@run.id}"
  end

  post '/login' do
    @user = User.find_by_id(:username => params[:username])
    if @user != nil && @user.password == params[:password]
      session[:user_id] = @user.id
      redirect to '/account'
    end
    erb :error
  end

  get '/account' do
    @current_user = User.find_by_id(session[:user_id])
    if @current_user
      erb:account
    else
      erb :error
    end
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end

  # READ

  get '/runs' do
    @runs = Run.all
    erb :index
  end

  # READ

  get '/runs/:id' do
    @run = Run.find_by_id(params[:id])
    erb :show
  end

  # UPDATE

  get '/runs/:id/edit' do
    @run = Run.find_by_id(params[:id])
    erb :edit
  end

  # UPDATE

  patch '/runs/:id' do
    @run = Run.find_by_id(params[:id])
    @run.time = params[:time]
    @run.distance = params[:distance]
    @run.hours = params[:hours]
    @run.minutes = params[:minutes]
    @run.seconds = params[:seconds]
    @run.save
    redirect to "/runs/#{@run.id}"
  end

  # DELETE

  delete '/runs/:id' do
    @run = Run.find_by_id(params[:id])
    @run.delete
    redirect to "/runs"
  end

end
