def select_player_marker(marker)
	loop do
		puts "Enter 'X' or 'O' to select a marker."
		marker.replace(gets.chomp.upcase)
		marker != 'X' && marker != 'O' ? puts('That is not a valid choice.') : break
	end
end

def select_computer_marker(player_marker, computer_marker)
	player_marker == 'X' ? computer_marker.replace('O') : computer_marker.replace('X')
end

def display_board(square_values, player_score, computer_score, player_marker, computer_marker)
	tic_tac_toe_board = ["Tic Tac Toe Board\n", "#{square_values[0]} | #{square_values[1]} | #{square_values[2]}", "-----------", "#{square_values[3]} | #{square_values[4]} | #{square_values[5]}", "-----------", "#{square_values[6]} | #{square_values[7]} | #{square_values[8]}", "Player Score (#{player_marker})         Computer Score (#{computer_marker})", "----------------         ------------------", "       #{player_score}                         #{computer_score}         "]
	tic_tac_toe_board.each {|line| line.length == 43 ? puts(line.center(101)) : puts(line.center(100))} 
end

def display_move_instructions(player_marker)
	instructions = ["Enter a number (0 - 8) to select a square on the board.", "Squares are numbered from top to bottom and left to right.", "For example, the top leftmost space is 0 and the bottom rightmost space is 8."]
	instructions.each {|line| puts(line.center(100))}
end

def select_square(square, square_values, marker)
	square_values[square].replace(marker)
end

def computer_move(square_values, computer_marker, player_marker)
	if square_values[4] == ' '
		select_square(4, square_values, computer_marker)
	else
		square_values.each do |square|
			if square == ' '
			select_square(4, square_values, computer_marker)
		end
	end
end

def win?(board_values, marker)
	winning_combos = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4 ,6]]

end






#-----------------------------

square_values = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
player_marker = ''
computer_marker = ''
player_score = 0
computer_score = 0

puts "Welcome to Tic Tac Toe!\n\n"

loop do
	puts "Enter 'N' to start a new game or 'Q' to quit."
	start_game = gets.chomp.upcase

	if start_game == 'Q'
		break
	elsif start_game == 'N'
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



