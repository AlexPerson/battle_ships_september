require 'sinatra/base'
require_relative 'water'
require_relative 'ship'
require_relative 'player'
require_relative 'game'
require_relative 'cell'
require_relative 'board'


class BattleshipWeb < Sinatra::Base
  
  enable :sessions

  set :views, proc { File.join(root, '..', 'views')}

  get '/' do
  	erb :index
  end

  post '/board-setup' do
  	session[:player_name] = params[:player_name]
  	redirect '/board-setup'
  end

  get '/board-setup' do
  	@player_name = session[:player_name]
  	erb :board_setup
  end

  # start the server if ruby file executed directly
  run! if app_file == $0

end
