class Board
	attr_reader :grid

	def initialize(content)
		@grid = {}
		[*"A".."J"].each do |l|
			[*1..10].each do |n| 
				@grid["#{l}#{n}".to_sym] = content.new
				@grid["#{l}#{n}".to_sym].content = Water.new
			end
		end
	end

	def place(ship, coord, orientation = :horizontally)
		coords = [coord]
		(ship.size - 1).times{coords << next_coord(coords.last, orientation)}
		put_on_grid_if_possible(coords, ship)
	end

	def floating_ships?
		ships.any?(&:floating?)
	end

	def shoot_at(coordinate)
		raise "You cannot hit the same square twice" if  grid[coordinate].hit?
		grid[coordinate].shoot
	end

	def ships
		grid.values.select{|cell|is_a_ship?(cell)}.map(&:content).uniq
	end

	def ships_count
		ships.count
	end

	def show_my_board
		result = "<div style='width:430'>"
		[*"A".."J"].each do |l|
			[*1..10].each do |n|
				if grid["#{l}#{n}".to_sym].content.is_a?(Water)
					if grid["#{l}#{n}".to_sym].hit == true
						yellow_div = "<div style='height:40px; width:40px; background-color:#DFDF5E; border:1px solid white; border-radius: 20px; display: inline-block'></div>"
						result += yellow_div
					else
						blue_div = "<div style='height:40px; width:40px; background-color:#0099FF; border:1px solid white; border-radius: 20px; display: inline-block'></div>"
						result += blue_div
					end
				else
					if grid["#{l}#{n}".to_sym].hit == true
						red_div = "<div style='height:40px; width:40px; background-color:#FF0000; border:1px solid white; border-radius: 20px; display: inline-block'></div>"
						result += red_div
					else
						green_div = "<div style='height:40px; width:40px; background-color:#009933; border:1px solid white; border-radius: 20px; display: inline-block'></div>"
						result += green_div
					end
				end 
			end
		end
		result += "</div>"
		return result
	end

private

 	def next_coord(coord, orientation)
		orientation == :vertically ? next_vertical(coord) : coord.next
	end

	def next_vertical(coord)
		coord.to_s.reverse.next.reverse.to_sym
	end

	def is_a_ship?(cell)
		cell.content.respond_to?(:sunk?) 
	end

	def any_coord_not_on_grid?(coords)
		(grid.keys & coords) != coords
	end

	def any_coord_is_already_a_ship?(coords)
		coords.any?{|coord| is_a_ship?(grid[coord])}
	end

	def raise_errors_if_cant_place_ship(coords)
		raise "You cannot place a ship outside of the grid" if any_coord_not_on_grid?(coords)
		raise "You cannot place a ship on another ship" if any_coord_is_already_a_ship?(coords)
	end

	def put_on_grid_if_possible(coords, ship)
		raise_errors_if_cant_place_ship(coords)
		coords.each{|coord|grid[coord].content = ship}
	end

end

