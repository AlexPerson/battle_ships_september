require 'sinatra/base'
require_relative 'water'
require_relative 'ship'
require_relative 'player'
require_relative 'game'
require_relative 'cell'
require_relative 'board'

class BattleshipWeb < Sinatra::Base
  
  set :views, proc { File.join(root, '..', 'views')}

  get '/' do
    erb :index
  end

  get '/name' do
  	@name = params[:name]
    erb :name_form
  end

  get '/board' do
    @board = Board.new(Cell)
    @coordinates = params[:coordinates]
    @ship_type = params[:ship_type]
    @orientation = params[:orientation]
  	erb :board
  end

  # start the server if ruby file executed directly
  run! if app_file == $0

end
