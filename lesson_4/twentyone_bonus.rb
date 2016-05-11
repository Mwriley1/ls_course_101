# Twenty One Bonus

CARDS = %w(A K Q J 10 9 8 7 6 5 4 3 2).freeze
WIN_TOTAL = 21
DEALER_HIT_LIMIT = 17

def initialize_deck
  (CARDS * 4).shuffle
end

def format_dealer_hand(dealer_hand)
  formatted_hand = []
  dealer_hand.each { |card| formatted_hand << card }
  formatted_hand[1] = '?'
  formatted_hand
end

def hand_total(hand)
  hand_total = 0
  
  hand.each do |card|
    if card == 'K' || card == 'Q' || card == 'J'
      hand_total += 10
    elsif card == 'A'
      hand_total += 11
    else
      hand_total += card.to_i
    end
  end

  hand.select { |card| card == 'A' }.count.times do
    hand_total -= 10 if hand_total > WIN_TOTAL
  end

  hand_total
end

def hit(hand, deck)
  hand << deck.pop
end

def display_cards(player_hand, dealer_hand, display_all=false)
  if display_all == true
    puts "\nPlayer Cards:  #{player_hand}     Player Hand Total: #{hand_total(player_hand)}"
    puts "Dealer Cards:  #{dealer_hand}     Dealer Hand Total: #{hand_total(dealer_hand)}\n\n"
  else
    puts "\nPlayer Cards:  #{player_hand}     Player Hand Total: #{hand_total(player_hand)}"
    puts "Dealer Cards:  #{format_dealer_hand(dealer_hand)}\n\n"
  end
end

def display_invalid_choice
  puts "That is not a valid choice.  Please select again."
end

def bust?(hand)
  hand_total(hand) > WIN_TOTAL
end

def display_hand_winner(player_hand, dealer_hand, scores)
  player_total = hand_total(player_hand)
  dealer_total = hand_total(dealer_hand)

  if bust?(player_hand)
    puts 'You have busted!  You lose!'
  elsif bust?(dealer_hand)
    puts 'The dealer has busted.  You win!'
  elsif player_total > dealer_total
    puts 'Your hand is greater than the dealers.  You win!'
  elsif player_total < dealer_total
    puts 'The dealers hand is greater than your hand.  You lose!'
  else
    puts 'Your hand and the dealers hand are equal.  It is a push!'
  end
  puts "Player Score: #{scores[:player]}     Dealer Score: #{scores[:dealer]}"
end

def keep_score(player_hand, dealer_hand, scores)
  player_total = hand_total(player_hand)
  dealer_total = hand_total(dealer_hand)

  if bust?(player_hand)
    scores[:dealer] += 1
  elsif bust?(dealer_hand)
    scores[:player] += 1
  elsif player_total > dealer_total
    scores[:player] += 1
  elsif player_total < dealer_total
    scores[:dealer] += 1
  end
end

def display_game_winner(scores)
  scores[:player] > scores[:dealer] ? puts('You have won the game!') : puts('The dealer has won the game!')
end

def new_game?
  puts 'Would you like to play another game? (Y or N)'
  gets.chomp.casecmp('Y') == 0 ? true : false
end

scores = {player: 0, dealer: 0}

puts "Welcome to Twenty One!"

loop do
  # Initialize variables

  deck = initialize_deck
  player_hand = []
  dealer_hand = []

  #system 'clear'
  # Inital deal

  2.times do
    player_hand << deck.pop
    dealer_hand << deck.pop
  end

  # Initial display of cards

  puts "\nAfter the initial deal, the player and the dealer have the following cards:"
  display_cards(player_hand, dealer_hand)

  # Player turn

  loop do
    puts "Would you like to (H)it or (S)tay?"
    hit_or_stay = gets.chomp.upcase
    display_invalid_choice if ['H', 'S'].include?(hit_or_stay) == false

    if hit_or_stay == 'H'
      hit(player_hand, deck)
      puts 'You chose to hit.  The player and dealer cards are now as follows:'
      display_cards(player_hand, dealer_hand)
    end

    break if hit_or_stay == 'S' || bust?(player_hand)
  end

  # Dealer turn

  dealer_hit = false

  if !bust?(player_hand)
    puts 'It is now the dealers turn.'

    loop do
      break if bust?(dealer_hand) || hand_total(dealer_hand) >= DEALER_HIT_LIMIT
      dealer_hit = true
      hit(dealer_hand, deck)
      puts 'The dealer hit.'
      display_cards(player_hand, dealer_hand, true)
    end
  else
    keep_score(player_hand, dealer_hand, scores)
    display_hand_winner(player_hand, dealer_hand, scores)
    if scores.has_value?(5)
       display_game_winner(scores)
       break unless new_game?
    end
    puts 'Dealing a new hand.'
    next
  end

  # Display winner if the player has not busted

  display_cards(player_hand, dealer_hand, true) if dealer_hit == false
  keep_score(player_hand, dealer_hand, scores)
  display_hand_winner(player_hand, dealer_hand, scores)
  if scores.has_value?(5)
    display_game_winner(scores)
    break unless new_game?
  end
  puts 'Dealing a new hand.'
end

# 1. The hand total can not be cached for all instances in the program because the value of hand total
# changes throughout the scope of the program.  When caching the hand total of the player or the dealer, 
# you must be certain the hand total will not change following the assignment.

# 2. The last play_again? in the example solution is different from the previous two because the previous 
# two need to skip over a part of the program if a yes response is given.  The last play_again? does not 
# because it is at the end of the program.   