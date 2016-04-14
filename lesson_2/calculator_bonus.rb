require 'yaml'
MESSAGES = YAML.load_file('calc_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def integer?(input)
  input.to_i == 0 && input != '0' ? false : true
end

def number?(input)
  if input.to_i == 0 && input != '0'
    false
  elsif input.to_f == 0.0 && input != '0'
    false
  else
    true
  end
end

def operation_to_message(operator)
  operation = case operator
                when '1'
                  'Adding'
                when '2'
                  'Subtracting'
                when '3'
                  'Multiplying'
                when '4'
                  'Dividing'
                end

  operation
end

prompt MESSAGES['welcome']
name = ''
loop do
  name = gets.chomp

  if name.empty?
    prompt MESSAGES['valid_name']
  else
    break
  end
end

prompt "Hi #{name}!"

loop do # main loop
  num_1 = ''

  loop do
    prompt MESSAGES['first_number']
    num_1 = gets.chomp

    if integer?(num_1)
      break
    else
      prompt MESSAGES['invalid_number']
    end
  end

  num_2 = ''

  loop do
    prompt MESSAGES['second_number']
    num_2 = gets.chomp

    if integer?(num_2)
      break
    else
      prompt MESSAGES['invalid_number']
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
      prompt MESSAGES['invalid_choice']
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
             prompt MESSAGES['invalid_operation']
           end

  prompt "The result is #{result}."

  prompt MESSAGES['another_calc']
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt MESSAGES['thank_you']
