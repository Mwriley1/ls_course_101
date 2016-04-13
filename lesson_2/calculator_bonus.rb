def prompt(message)
  puts "=> #{message}"
end

def valid_number?(number)
  number.to_i != 0
end

def operation_to_message(operator)
  case operator
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt 'Welcome to the calculator! Enter your name:'
name = ''
loop do
  name = gets.chomp

  if name.empty?
    prompt 'Please enter a valid name.'
  else
    break
  end
end

prompt "Hi #{name}!"

loop do # main loop
  num_1 = ''

  loop do
    prompt 'Enter the first number:'
    num_1 = gets.chomp

    if valid_number?(num_1)
      break
    else
      prompt('Invalid number.')
    end
  end

  num_2 = ''

  loop do
    prompt 'Enter the second number:'
    num_2 = gets.chomp

    if valid_number?(num_2)
      break
    else
      prompt('Invalid number.')
    end
  end

  operation_prompt = <<-MSG
    Enter the operation to perform:
       1) Add
       2) Subtract
       3) Multiply
       4) Divide
  MSG

  prompt operation_prompt

  operation = ''
  loop do
    operation = gets.chomp

    if %w(1 2 3 4).include?(operation)
      break
    else
      prompt 'You must enter 1, 2, 3, or 4.'
    end
  end

  prompt "#{operation_to_message(operation)} the two numbers..."

  result = case operation
           when '1'
             num_1.to_i + num_2.to_i
           when '2'
             num_1.to_i - num_2.to_i
           when '3'
             num_1.to_i * num_2.to_i
           when '4'
             num_1.to_f / num_2.to_f
           else
             prompt 'That is not a valid operation.'
           end

  prompt "The result is #{result}."

  prompt 'Do you want to perform another calculatrion? (Y or N)'
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt 'Thank you for using Calculator!'
