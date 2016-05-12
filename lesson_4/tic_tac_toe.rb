# Tic Tac Toe

WINNNING_COMBOS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
                   [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]].freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
INITIAL_SQUARE = ' '.freeze

def initialize_board!(board)
  (0..8).each { |num| board[num] = INITIAL_SQUARE }
end

def display_board(board)
  tic_tac_toe_board = ["Tic Tac Toe Board\n",
                       "#{board[0]} | #{board[1]} | #{board[2]}", "-----------",
                       "#{board[3]} | #{board[4]} | #{board[5]}", "-----------",
                       "#{board[6]} | #{board[7]} | #{board[8]}"]

  system 'clear'
  tic_tac_toe_board.each { |line| puts(line.center(44)) }
  puts ''
end

def find_empty_squares(board)
  empty_squares = []
  board.each_index { |index| empty_squares << index if board[index] == ' ' }
  empty_squares
end

def player_select_square(board, marker)
  empty_squares = find_empty_squares(board)

  loop do
    puts "Select a square (#{empty_squares.join(', ')})."
    square = gets.chomp
    if (square != '0' && square.to_i == 0) || empty_squares.include?(square.to_i) == false
      puts "That is not a valid choice."
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

def display_winner_or_draw(board)
  if win?(board, PLAYER_MARKER)
    puts 'You win!'
  elsif win?(board, COMPUTER_MARKER)
    puts 'The computer wins!'
  else
    puts "It's a draw!"
  end
end

# Main Program Start-------------------------

puts "Welcome to Tic Tac Toe!\n\n"

loop do
  play_a_game = ''

  loop do # Input validation loop
    puts "Enter 'N' to start a new game or 'Q' to quit."
    play_a_game = gets.chomp.upcase
    ['N', 'Q'].include?(play_a_game) ? break : puts('That is not a valid choice.')
  end

  break if play_a_game == 'Q'

  board = []
  initialize_board!(board)
  display_board(board)

  loop do # Game loop
    player_select_square(board, PLAYER_MARKER)
    display_board(board)
    break if win?(board, PLAYER_MARKER) || find_empty_squares(board).empty?

    computer_select_square(board, COMPUTER_MARKER)
    display_board(board)
    break if win?(board, COMPUTER_MARKER)
  end

  display_winner_or_draw(board)
end
