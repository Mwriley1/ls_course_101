def display_welcome
	puts 'Welcome to Tic Tac Toe!'
end

def select_player_marker(marker)
	puts 'Enter X or O to select a marker.'
	marker.replace(gets.chomp.upcase)
	if marker != 'X' && marker != 'O'
		puts 'That is not a valid choice.'
		select_player_marker(marker)
	else
		puts "You have selected #{marker}!"
	end
end

def select_computer_marker(player_marker, computer_marker)
	player_marker == 'X' ? computer_marker.replace('O') : computer_marker.replace('X')
end

def display_board(square_values, player_score, computer_score, player_marker, computer_marker)
	puts <<-MSG

	            Tic Tac Toe Board


	                #{square_values[0]} | #{square_values[1]} | #{square_values[2]}
	               -----------
	                #{square_values[3]} | #{square_values[4]} | #{square_values[5]}
	               -----------
	                #{square_values[6]} | #{square_values[7]} | #{square_values[8]}


	Player Score (#{player_marker})         Computer Score (#{computer_marker})
	----------------         ------------------
 	        #{player_score}                        #{computer_score}

	MSG
end

def display_move_instructions(player_marker)
	puts <<-MSG

	Enter a number (0 - 8) to select a square on the board from top to bottom and left to right.
	For example, the top leftmost space is 0 and the bottom rightmost space is 8.

	MSG
end

def select_square(square, square_values, player_marker)
	square_values[square].replace(player_marker)
end

def win?(board_values, marker)
	winning_combos = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4 ,6]]
	count = 0
	winning_combos.each do |combo|
		combo.each do |square|
			puts square
			if board_values[square] == marker
				#puts count
				count += 1
			end
			if count == 3
				return true
			end
		end
	end
	false
end

def tie?

end


#-----------------------------

square_values = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
player_marker = ''
computer_marker = ''
player_score = 0
computer_score = 0

display_welcome

loop do
	puts 'Enter N to start a new game or Q to quit.'
	new_game = gets.chomp.upcase

	if new_game == 'Q'
		break
	elsif new_game == 'N'
		select_player_marker(player_marker)
		select_computer_marker(player_marker, computer_marker)
		
		loop do
			display_board(square_values, player_score, computer_score, player_marker, computer_marker)
			display_move_instructions(player_marker)
			player_selection = gets.chomp.to_i

			select_square(player_selection, square_values, player_marker)
			p square_values
			#puts win?(square_values, player_marker)
			break if win?(square_values, player_marker)
		end
	else
		puts 'That is not a valid choice.'
	end
end



