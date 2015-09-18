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

  get '/test-page' do
  	@board = Board.new(Cell)
  	@board.place(Ship.destroyer, :A1)
  	@board.place(Ship.battleship, :E1)
  	@board.shoot_at(:A1)
  	@board.shoot_at(:A2)
  	@board.shoot_at(:B1)
  	@board.shoot_at(:B2)
  	# @my_board = "<div style='height:100px; width:200px; background-color:#bfc4bf; boarder:1px solid white'></div><div style='height:100px; width:200px; background-color:#bfc4bf; boarder:1px solid white'></div>"
  	@my_board = @board.show_my_board
  	erb :test_page
  end

  # start the server if ruby file executed directly
  run! if app_file == $0

end
