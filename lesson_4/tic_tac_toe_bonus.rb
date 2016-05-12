# Tic Tac Toe Bonus

WINNNING_COMBOS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
                   [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]].freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
INITIAL_SQUARE = ' '.freeze
PLAYS_FIRST = 'player'.freeze # Options: 'player', 'computer', or 'choose'

def initialize_board!(board)
  (0..8).each { |num| board[num] = INITIAL_SQUARE }
end

def display_board(board)
  tic_tac_toe_board = ["Tic Tac Toe Board\n",
                       "#{board[0]} | #{board[1]} | #{board[2]}", "-----------",
                       "#{board[3]} | #{board[4]} | #{board[5]}", "-----------",
                       "#{board[6]} | #{board[7]} | #{board[8]}"]

  system 'clear'
  tic_tac_toe_board.each { |line| puts(line.center(48)) }
  puts ''
end

def find_empty_squares(board)
  empty_squares = []
  board.each_index { |index| empty_squares << index if board[index] == ' ' }
  empty_squares
end

def set_current_player
  player_choice = ''
  loop do
    puts "Who should play first?  Type 'P' for player or 'C' for computer"
    player_choice = gets.chomp.upcase
    break if ['P', 'C'].include?(player_choice)
    puts 'That is not a valid choice.'
  end
  player_choice == 'P' ? 'player' : 'computer'
end

def player_select_square(board, marker)
  empty_squares = find_empty_squares(board)

  loop do
    puts "Select a square (#{joinor(empty_squares)})."
    square = gets.chomp
    if (square != '0' && square.to_i == 0) || empty_squares.include?(square.to_i) == false
      puts "That is not a valid choice."
    else
      board[square.to_i] = marker
      break
    end
  end
end

def search_board(board, action='') # Default action is to search the board for a block
  marker = action == 'win' ? COMPUTER_MARKER : PLAYER_MARKER

  squares_to_check = []
  WINNNING_COMBOS.each do |combo|
    3.times { |int| squares_to_check[int] = board[combo[int]] }
    if squares_to_check.count(marker) == 2 && squares_to_check.count(' ') == 1
      return combo[squares_to_check.index(' ')]
    end
  end
  nil
end

def computer_select_square(board)
  empty_squares = find_empty_squares(board)
  if search_board(board, 'win')
    board[search_board(board, 'win')] = COMPUTER_MARKER
  elsif search_board(board)
    board[search_board(board)] = COMPUTER_MARKER
  elsif board[4] == ' '
    board[4] = COMPUTER_MARKER
  else
    board[empty_squares.sample] = COMPUTER_MARKER unless empty_squares.empty? == true
  end
end

def win?(board, marker)
  squares_to_check = []
  WINNNING_COMBOS.each do |combo|
    3.times { |int| squares_to_check[int] = board[combo[int]] }
    if squares_to_check.count(marker) == 3
      return true
    end
  end
  false
end

def draw?(board)
  board.include?(' ') ? false : true
end

def joinor(array, delimiter=', ', conjunction='or ')
  delimiter = ' ' if array.length < 3
  selectable_squares = array.join(delimiter)
  selectable_squares.insert(selectable_squares.length - 1, conjunction) if array.length > 1
  selectable_squares
end

def display_result(scores, exit_match, winner='')
  if winner == 'player'
    puts 'You win!'
  elsif winner == 'computer'
    puts 'The Computer wins!'
  else
    puts "It's a draw!"
  end

  puts "Player Score: #{scores[:player]} Computer Score: #{scores[:computer]}"
  if !scores.value?(5)
    puts "Type 'E' to exit the match or press any other key to continue."
    exit_match.replace('E') if gets.chomp.casecmp('E') == 0
  end
end

def player_turn(board, exit_match, scores)
  player_select_square(board, PLAYER_MARKER)
  display_board(board)

  if win?(board, PLAYER_MARKER)
    scores[:player] += 1
    display_result(scores, exit_match, 'player')
  elsif draw?(board)
    display_result(scores, exit_match)
  end
end

def computer_turn(board, exit_match, scores)
  computer_select_square(board)
  display_board(board)

  if win?(board, COMPUTER_MARKER)
    scores[:computer] += 1
    display_result(scores, exit_match, 'computer')
  elsif draw?(board)
    display_result(scores, exit_match)
  end
end

def alternate_player(current_player)
  current_player == 'player' ? 'computer' : 'player'
end

def select_square(current_player, board, exit_match, scores)
  if current_player == 'player'
    player_turn(board, exit_match, scores)
  else
    computer_turn(board, exit_match, scores)
  end
end

def display_match_winner(scores)
  if scores[:player] == 5
    puts 'You have won the match!'
  elsif scores[:computer] == 5
    puts "The computer has won the match!\n\n"
  else
    puts "You have exited the match\n\n"
  end
end

# Main Program Start-------------------------

puts "Welcome to Tic Tac Toe!\n\n"

loop do
  board = []
  scores = { player: 0, computer: 0 }
  current_player = ''
  exit_match = ''

  puts "Enter 'N' to start a new match (first to five wins) or 'Q' to quit."
  play_a_game = gets.chomp.upcase

  if play_a_game == 'Q'
    break
  elsif play_a_game == 'N'

    loop do # Match loop
      break if scores.value?(5) || exit_match == 'E'
      current_player = PLAYS_FIRST == 'choose' ? set_current_player : PLAYS_FIRST
      initialize_board!(board)
      display_board(board)

      loop do # Game loop
        select_square(current_player, board, exit_match, scores)
        current_player = alternate_player(current_player)

        break if win?(board, PLAYER_MARKER) ||
                 win?(board, COMPUTER_MARKER) ||
                 draw?(board)
      end
    end
  else
    puts 'That is not a valid choice.'
  end

  display_match_winner(scores)
  puts "Thanks for playing Tic Tac Toe!\n\n"
end
