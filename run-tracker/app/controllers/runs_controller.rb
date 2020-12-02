class RunsController < ApplicationController

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
    @run.destroy
    redirect to "/runs"
  end

end