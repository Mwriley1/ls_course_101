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
  puts "Select a square (#{empty_squares.join(', ')}).".center(100)
  square = gets.chomp
  loop do
    if square != '0' && square.to_i == 0 || empty_squares.include?(square.to_i) == false
      puts 'That is not a valid choice.'
      puts "Please select a square (#{empty_squares.join(', ')})."
      square = gets.chomp
    else
      board[square.to_i] = marker
      break
    end
  end
end

def computer_select_square(board, marker)
  empty_squares = find_empty_squares(board)
  board[empty_squares.sample] = marker unless empty_squares.empty? == true
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

# Main Program Start-------------------------

puts "Welcome to Tic Tac Toe!\n\n"

loop do 
  puts "Enter 'N' to start a new game or 'Q' to quit."
  play_a_game = gets.chomp.upcase

  if play_a_game == 'Q'
    break
  elsif play_a_game == 'N'    
    board = []

    initialize_board(board)
    display_board(board, PLAYER_MARKER, COMPUTER_MARKER)

    loop do 
      player_select_square(board, PLAYER_MARKER)
      display_board(board, PLAYER_MARKER, COMPUTER_MARKER)
      if win?(board, WINNNING_COMBOS, PLAYER_MARKER)
        puts 'You win!'
        break
      end 

      computer_select_square(board, COMPUTER_MARKER)
      display_board(board, PLAYER_MARKER, COMPUTER_MARKER)
      if win?(board, WINNNING_COMBOS, COMPUTER_MARKER)
        puts 'The Computer wins!'
        break
      end

      if find_empty_squares(board).empty?
        puts "It's a draw!"
        break
      end
    end
  else
    puts 'That is not a valid choice.'
  end
end 



