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

def player_select_square(square, square_values, marker)
  loop do
    if square != '0' && square.to_i == 0 || square_values[square.to_i] != ' '
      puts 'That is not a valid choice.'
      puts 'Please select a square.'
      square = gets.chomp
    else
      square_values[square.to_i].replace(marker)
      break
    end
  end
end

def search_board(square_values, winning_combos, player_marker, computer_marker, action)
  moves = nil
  open_spaces = nil
  marker = nil
  
  case action.downcase
  when 'win'
    moves = 2
    open_spaces = 1
    marker = computer_marker
  when 'block'
    moves = 2
    open_spaces = 1
    marker = player_marker
  when 'open'
    moves = 1
    open_spaces = 2
    marker = computer_marker
  end

  test_array = []
  winning_combos.each do |combo|
    3.times {|int| test_array[int] = square_values[combo[int]]}
    if test_array.count(marker) == moves && test_array.count(' ') == open_spaces
      return combo[test_array.index(' ')]
    end
  end
  nil
end

def pick_open_spot(square_values, winning_combos, player_marker, computer_marker)
  corners_array = [square_values[0], square_values[2], square_values[6], square_values[8]]
  if search_board(square_values, winning_combos, player_marker, computer_marker, 'open')
    move = search_board(square_values, winning_combos, player_marker, computer_marker, 'open')
  elsif square_values[4] == ' '
    move = 4
  elsif corners_array.include?(' ')
    case corners_array.index(' ')
    when 0
      move = 0
    when 1 
      move = 2
    when 2
      move = 6
    else
      move = 8
    end
  else
    move = square_values.index(' ')
  end
end

def computer_move(square_values, winning_combos, player_marker, computer_marker)
  if search_board(square_values, winning_combos, player_marker, computer_marker, 'win')
    move = search_board(square_values, winning_combos, player_marker, computer_marker, 'win')
  elsif search_board(square_values, winning_combos, player_marker, computer_marker, 'block')
    move = search_board(square_values, winning_combos, player_marker, computer_marker, 'block')
  else
    move = pick_open_spot(square_values, winning_combos, player_marker, computer_marker)
  end
  square_values[move].replace(computer_marker)
end

def win_game?(square_values, winning_combos, player_marker, computer_marker)
  test_array = []
  winning_combos.each do |combo|
    3.times {|int| test_array[int] = square_values[combo[int]]}
    if test_array.count(player_marker) == 3 
      return player_marker
    elsif test_array.count(computer_marker) == 3
      return computer_marker
    end
  end
  false
end

def display_winner(square_values, winning_combos, player_marker, computer_marker, player_score, computer_score)
  if win_game?(square_values, winning_combos, player_marker, computer_marker) == player_marker
    display_board(square_values, player_score, computer_score, player_marker, computer_marker)
    puts 'You win!'
  else
    display_board(square_values, player_score, computer_score, player_marker, computer_marker)
    puts 'The computer wins!'
  end
end

#-----------------------------

winning_combos = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4 ,6]]
player_score = 0
computer_score = 0


#=begin

puts "Welcome to Tic Tac Toe!\n\n"

loop do
	puts "Enter 'N' to start a new game or 'Q' to quit."
	start_game = gets.chomp.upcase

	if start_game == 'Q'
		break
	elsif start_game == 'N'
		square_values = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
    player_marker = ''
    computer_marker = ''

    select_player_marker(player_marker)
		select_computer_marker(player_marker, computer_marker)
		
		loop do
      if win_game?(square_values, winning_combos, player_marker, computer_marker)
        if win_game?(square_values, winning_combos, player_marker, computer_marker) == player_marker
          display_winner(square_values, winning_combos, player_marker, computer_marker, player_score, computer_score)
          player_score += 1
          break
        else
          display_winner(square_values, winning_combos, player_marker, computer_marker, player_score, computer_score)
          computer_score += 1
          break
        end
      end

      display_board(square_values, player_score, computer_score, player_marker, computer_marker)
			display_move_instructions(player_marker)
			
      player_selection = gets.chomp
			player_select_square(player_selection, square_values, player_marker)
      display_board(square_values, player_score, computer_score, player_marker, computer_marker)

      if square_values.include?(' ') == false && win_game?(square_values, winning_combos, player_marker, computer_marker) == false
        puts "It's a draw!"
        break
      end

			computer_move(square_values, winning_combos, player_marker, computer_marker)
		end
	else
		puts 'That is not a valid choice.'
	end
end

#=end

