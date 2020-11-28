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

  end

  get '/runs' do

  end

  post '/runs' do

  end

  get '/runs/:id' do

  end

  get '/runs/:id/edit' do

  end

  patch '/runs/:id' do

  end

  delete '/runs/:id' do

  end

end
