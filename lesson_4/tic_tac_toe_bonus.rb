#Tic Tac Toe
require 'pry'

WINNNING_COMBOS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4 ,6]]
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
INITIAL_SQUARE = ' '
PLAYS_FIRST = 'choose'

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

def set_current_player()
  case PLAYS_FIRST
  when 'player'
    current_player = 'player'
  when 'computer'
    current_player = 'computer'
  when 'choose'
    loop do
      puts "Who should play first?  Type 'p' for player or 'c' for computer"
      user_choice = gets.chomp
      if user_choice.downcase == 'p'
        current_player = 'player'
        break
      elsif user_choice.downcase == 'c'
        current_player = 'computer'
        break
      else
        puts 'That is not a valid choice.'
      end    
    end
    current_player
  end
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

def draw?(board)
  find_empty_squares(board).empty? ? true : false
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

def display_win_or_draw(winner, scores)
  if winner == 'player'
    puts 'You win!'
    scores['player'] += 1
  elsif winner == 'computer'
    puts 'The Computer wins!'
    scores['computer'] += 1
  else
    puts "It's a draw!"
  end
    display_score(scores['player'], scores['computer'])
    puts 'Press any key to continue'
    gets.chomp
end

def player_turn(board, winning_combos, player_marker, computer_marker, scores)
  player_select_square(board, PLAYER_MARKER)
  display_board(board, PLAYER_MARKER, COMPUTER_MARKER)
  if win?(board, WINNNING_COMBOS, PLAYER_MARKER)
    display_win_or_draw('player', scores)
  elsif draw?(board)
    display_win_or_draw('draw', scores)
  end 
end

def computer_turn(board, winning_combos, player_marker, computer_marker, scores)
  computer_select_square(board, WINNNING_COMBOS, PLAYER_MARKER, COMPUTER_MARKER)
  display_board(board, PLAYER_MARKER, COMPUTER_MARKER)
  if win?(board, WINNNING_COMBOS, COMPUTER_MARKER)
    display_win_or_draw('computer', scores)
  elsif draw?(board)
    display_win_or_draw('draw', scores)
  end
end

def alternate_player(current_player)
  current_player == 'player' ? current_player = 'computer' : current_player = 'player'
  current_player
end

def select_square(current_player, board, winning_combos, player_marker, computer_marker, scores)
  if current_player == 'player'
    player_turn(board, winning_combos, player_marker, computer_marker, scores)
  else
    computer_turn(board, winning_combos, player_marker, computer_marker, scores)
  end
  alternate_player(current_player)
end

# Main Program Start-------------------------

puts "Welcome to Tic Tac Toe!\n\n"

loop do 
  board = []
  scores = {'player' => 0, 'computer' => 0}
  current_player = ''

  puts "Enter 'N' to start a new match (first to five wins) or 'Q' to quit."
  play_a_game = gets.chomp.upcase

  if play_a_game == 'Q'
    break
  elsif play_a_game == 'N'
    loop do 
      break if scores.has_value?(5)
      current_player = set_current_player()
      initialize_board(board)    
      display_board(board, PLAYER_MARKER, COMPUTER_MARKER)

      loop do 
        select_square(current_player, board, WINNNING_COMBOS, PLAYER_MARKER, COMPUTER_MARKER, scores)
        current_player = alternate_player(current_player)
        break if win?(board, WINNNING_COMBOS, PLAYER_MARKER) || 
        win?(board, WINNNING_COMBOS, COMPUTER_MARKER) ||
        draw?(board)
      end
    end
  else
    puts 'That is not a valid choice.'
  end
end 



