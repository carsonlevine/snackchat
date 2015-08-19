# Set environment
require "./config/environment"

# Get models
require "./app/models/snack"

# Set routs
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
  end

  # Home page
  get "/" do
    @all_snacks = Snack.all
    erb :index
  end

  # User page
  get "/user/:username" do
    username = params[:username]
    @my_snacks = Snack.where(receiver: username)
    erb :user
  end

  # Snack page
  get "/snack/:id" do
    id = params[:id]
    @snack = Snack.where(id: id)
    erb :snack
  end

  # Home page
  get "/send" do
    erb :send
  end

  # send snacks
  post '/send_snack' do
    snack = Snack.new({
      username: params[:username],
      snack: params[:snack],
      receiver: params[:receiver],
      timestamp: params[:timestamp]
    })
    snack.save
    redirect "/"
  end
end
