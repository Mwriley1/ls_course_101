# Twenty One
require 'pry'
CARDS = %w(A K Q J 10 9 8 7 6 5 4 3 2).freeze

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
    hand_total -= 10 if hand_total > 21
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
  hand_total(hand) > 21
end

def display_winner(player_hand, dealer_hand)
  if bust?(player_hand)
    puts 'You have busted!  You lose!'
  elsif bust?(dealer_hand)
    puts 'The dealer has busted.  You win!'
  elsif hand_total(player_hand) > hand_total(dealer_hand)
    puts 'Your hand is greater than the dealers.  You win!'
  elsif hand_total(player_hand) < hand_total(dealer_hand)
    puts 'The dealers hand is greater than your hand.  You lose!'
  else
    puts 'Your hand and the dealers hand are equal.  It is a push!'
  end
end

def deal_new_hand?
  puts 'Would you like to deal another hand? (Y or N)'
  gets.chomp.casecmp('Y') == 0 ? true : false
end

loop do
  # Initialize variables

  deck = initialize_deck
  player_hand = []
  dealer_hand = []

  system 'clear'
  puts "Welcome to Twenty One!"

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
      break if bust?(dealer_hand) || hand_total(dealer_hand) >= 17
      dealer_hit = true
      hit(dealer_hand, deck)
      puts 'The dealer hit.'
      display_cards(player_hand, dealer_hand, true)
    end
  else
    display_winner(player_hand, dealer_hand)
    !deal_new_hand? ? break : next
  end

  # Display winner if the player has not busted

  display_cards(player_hand, dealer_hand, true) if dealer_hit == false
  display_winner(player_hand, dealer_hand)
  break unless deal_new_hand?
end
