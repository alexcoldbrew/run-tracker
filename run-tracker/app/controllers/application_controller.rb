require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end

  get '/runs/new' do
    erb :new
  end

  get '/runs' do
    @runs = Run.all
    erb :index
  end

  post '/runs' do
    @run = Run.create(:time => params[:time], :distance => params[:distance], :hours => params[:hours], :minutes => params[:minutes], :seconds => params[:seconds])
    redirect to "/runs/#{@run.id}"
  end

  get '/runs/:id' do
    @run = Run.find_by_id(params[:id])
    erb :show
  end

  get '/runs/:id/edit' do
    @run = Run.find_by_id(params[:id])
    erb :edit
  end

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

  delete '/runs/:id' do
    @run = Run.find_by_id(params[:id])
    @run.delete
    redirect to "/runs"
  end

end
