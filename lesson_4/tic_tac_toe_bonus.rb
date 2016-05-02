#Tic Tac Toe
require 'pry'

WINNNING_COMBOS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4 ,6]]
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
INITIAL_SQUARE = ' '


def initialize_board(board)
  new_board = board
  (0..8).each {|num| new_board[num] = INITIAL_SQUARE}
  new_board
end

def display_board(board, player_marker, computer_marker)
  tic_tac_toe_board = ["Tic Tac Toe Board\n", "#{board[0]} | #{board[1]} | #{board[2]}", "-----------", "#{board[3]} | #{board[4]} | #{board[5]}", "-----------", "#{board[6]} | #{board[7]} | #{board[8]}"]
  system 'clear'
  tic_tac_toe_board.each {|line| line.length == 43 ? puts(line.center(100)) : puts(line.center(100))} 
end

def find_empty_squares(board)
  empty_squares = []
  board.each_index {|index| empty_squares << index if board[index] == ' '}
  empty_squares
end

def player_select_square(board, marker)
  empty_squares = find_empty_squares(board)
  
  puts ''
  puts "Select a square (#{joinor(empty_squares)}).".center(100)
  square = gets.chomp
  loop do
    if square != '0' && square.to_i == 0 || empty_squares.include?(square.to_i) == false
      puts 'That is not a valid choice.'
      puts "Please select a square (#{joinor(empty_squares)})."
      square = gets.chomp
    else
      board[square.to_i] = marker
      break
    end
  end
end

def search_board(board, winning_combos, player_marker, computer_marker, action)
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
  end

  squares_to_check = []
  winning_combos.each do |combo|
    3.times {|int| squares_to_check[int] = board[combo[int]]}
    if squares_to_check.count(marker) == moves && squares_to_check.count(' ') == open_spaces
      return combo[squares_to_check.index(' ')]
    end
  end
  nil
end

def computer_select_square(board, winning_combos, player_marker, computer_marker)
  empty_squares = find_empty_squares(board)
  if search_board(board, winning_combos, player_marker, computer_marker, 'win')
    board[search_board(board, winning_combos, player_marker, computer_marker, 'win')] = computer_marker
  elsif search_board(board, winning_combos, player_marker, computer_marker, 'block')
    board[search_board(board, winning_combos, player_marker, computer_marker, 'block')] = computer_marker
  else
    if empty_squares.include?(4)
      board[4] = computer_marker
    else
      board[empty_squares.sample] = computer_marker unless empty_squares.empty? == true
    end
  end
end

def win?(board, winning_combos, marker)
  squares_to_check = []
  winning_combos.each do |combo|
    3.times {|int| squares_to_check[int] = board[combo[int]]}
    if squares_to_check.count(marker) == 3
      return true
    end
  end
  false
end

def joinor(array, delimiter=', ', conjunction='or ')
  delimiter = ' ' if array.length < 3
  selectable_squares = array.join(delimiter)
  selectable_squares.insert(selectable_squares.length - 1, conjunction) if array.length > 1
  selectable_squares
end

def display_score(player_score, computer_score)
  puts "Player Score: #{player_score} Computer Score: #{computer_score}"
end

# Main Program Start-------------------------

puts "Welcome to Tic Tac Toe!\n\n"

loop do 
  player_score = 0
  computer_score = 0

  puts "Enter 'N' to start a new match (first to five wins) or 'Q' to quit."
  play_a_game = gets.chomp.upcase

  if play_a_game == 'Q'
    break
  elsif play_a_game == 'N'
    loop do 
      break if player_score >= 5 || computer_score >= 5    
      board = []

      initialize_board(board)
      display_board(board, PLAYER_MARKER, COMPUTER_MARKER)

      loop do 
        player_select_square(board, PLAYER_MARKER)
        display_board(board, PLAYER_MARKER, COMPUTER_MARKER)
        if win?(board, WINNNING_COMBOS, PLAYER_MARKER)
          puts 'You win!'
          player_score += 1
          display_score(player_score, computer_score)
          puts 'Press any key to continue'
          gets.chomp
          break
        end 

        computer_select_square(board, WINNNING_COMBOS, PLAYER_MARKER, COMPUTER_MARKER)
        display_board(board, PLAYER_MARKER, COMPUTER_MARKER)
        if win?(board, WINNNING_COMBOS, COMPUTER_MARKER)
          puts 'The Computer wins!'
          player_score += 1
          display_score(player_score, computer_score)
          puts 'Press any key to continue'
          gets.chomp
          break
        end

        if find_empty_squares(board).empty?
          puts "It's a draw!"
          puts 'Press any key to continue'
          gets.chomp
          break
        end
      end
    end
  else
    puts 'That is not a valid choice.'
  end
end 



