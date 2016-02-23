VALID_CHOICES= %w(rock paper scissors lizard spock)

player_score = 0
computer_score = 0

def prompt(message)
  puts "=> #{message}"
end

def convert_to_full(string)
  case string
  when 'r'
    'rock'
  when 'sc'
    'scissors'
  when 'p'
    'paper'
  when 'l'
    'lizard'
  when 'sp'
    'spock'
  else
    string
  end
end

def win?(first, second)
  first == 'rock' && second == 'scissors' ||
  first == 'rock' && second == 'lizard' ||
    first == 'paper' && second == 'rock' ||
    first == 'paper' && second == 'spock' ||
    first == 'scissors' && second == 'paper' ||
    first == 'scissors' && second == 'lizard' ||
    first == 'lizard' && second == 'spock' ||
    first == 'lizard' && second == 'paper' ||
    first == 'spock' && second == 'scissors' ||
    first == 'spock' && second == 'rock'
end

def display_results(player, computer)
  if win?(player, computer)
    prompt 'You won!'
  elsif win?(computer, player)
    prompt 'You lost!'
  else
    prompt "It's a tie!"
  end
end

def keep_score(p_choice, c_choice, p_score, c_score)
  if win?(p_choice, c_choice)
    p_score += 1
  elsif win?(c_choice, p_choice)
    c_score += 1
  end
  return p_score, c_score
end

loop do
  choice = ''
  loop do
    prompt <<-MSG 

    Choose one: #{VALID_CHOICES.join(', ')}
    Note: You may enter the full word or use the abbreviations below.

    'r' for rock
    'sc' for scissors
    'p' for paper
    'l' for lizard
    'sp' for spock

    MSG
    
    choice = gets.chomp
    choice = convert_to_full(choice)
    p choice

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice")
    end
  end

  computer_choice = VALID_CHOICES.sample

  prompt "You chose: #{(choice)}. The Computer chose: #{computer_choice}."
  player_score, computer_score = keep_score(choice, computer_choice, player_score, computer_score)
  display_results(choice, computer_choice)   
  prompt "Player Score: #{player_score}  Computer Score: #{computer_score}"

  if player_score == 5
    prompt 'You won the match!'
    player_score = 0
    computer_score = 0
    prompt 'Do you want to play again?'
    answer = gets.chomp
    break unless answer.downcase.start_with? 'y'
  elsif computer_score == 5
    prompt 'The computer won the match!'
    player_score = 0r
    computer_score = 0
    prompt 'Do you want to play again?'
    answer = gets.chomp
    break unless answer.downcase.start_with? 'y'
  end
end

prompt 'Thank you for playing. Good bye!'
