
puts 'Welcome to the loan payment calculator!'

loop do
  loan_amt = nil
  loop do
    puts 'Please enter the desired loan amount:'
    loan_amt = gets.chomp.to_i
    break unless loan_amt.nil? || loan_amt < 0
    puts 'That is not a valid loan amount.'
  end

  apr = nil
  loop do
    puts 'Please enter an Annual Percentage Rate (APR):'
    apr = gets.chomp.to_f
    break unless apr.nil? || apr < 0
    puts 'That is not a valid APR.'
  end

  loan_term = nil
  loop do
    puts 'Please enter the desired loan term in years:'
    loan_term = gets.chomp.to_i
    break unless loan_term.nil? || loan_term < 0
    puts 'That is not a valid loan term.'
  end

  loan_term *= 12
  int_rate = (apr / 100) / 12
  loan_pmt = loan_amt * (int_rate * (1 + int_rate)**loan_term) / ((1 + int_rate)**loan_term - 1)

  puts <<-MSG

  Based on the loan terms below:

  Loan Amount: $#{loan_amt}
  Loan APR: #{apr}%
  Loan Duration: #{loan_term / 12} years

  Your calculated monthly payment is: $#{loan_pmt}

  MSG

  puts 'Would you like to calculate another monthly loan payment? (Y or N)'
  continue = gets.chomp.downcase

  break unless continue == 'y'
end

puts 'Thank you for using the loan calculator!'
