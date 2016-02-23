#1. 

10.times {|i| puts 'The Flintstones Rock!'.center(21 + (i*2))}

#2.

statement = "The Flintstones Rock"
letters = []
frequency = {}

statement.gsub!(' ','')
statement.each_char {|char| letters << char} 
letters.each {|letter| frequency[letter] = letters.count(letter)}

#3. 

#The interpreter cannot concatenate an integer with a string.
#You could use string interpolation or convert the integer to a string 
#using the to_s method.

#4.

#The output would be:
#1 3
#1 2

#5.

def factors(number)
  dividend = number
  divisors = []
  while dividend > 0
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
  divisors
end

#p factors(42)
#p factors(-3)
#p factors(0)

#Bonus 1: When number % dividend is equal to zero, it means there is no remainder and
#the dividend divides evenly into the number submitted.

#Bonus 2:To return the list of divisors instead of nil.

#6.

#The << operator modifies the input array by appending an element.
#Using the + operator returns the same concatenated array but
#does not modify the input array.

#7.

#limit is not provided to the method as a parameter, therefore it has no way to access it.
#It could be fixed by defining limit within the method or adding it as a parameter for the
#user to define.

def fib(first_num, second_num, limit)
  while second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, 15)
puts "result is #{result}"

#8.

=begin
Split the words of the string into an array
Iterate over each word in array
  Capitalize the first letter of each word
join all elements of the array and return
=end

def titleize(string)
  words = string.split
  words.each{|word| word.capitalize!}
  words.join(' ')
end

p titleize('thank you for smoking')

#9.

=begin
Deterimine age_group value
  if age is 0-17 then kid
  if age is 18 to 64 then adult
  if age is 65+ then senior
Add age_group to each family member's stats
=end

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each_value do |stats|
  case stats['age']
  when 0...17
    stats['age_group'] = 'kid'
  when 18...64
    stats['age_group'] = 'adult'
  else
    stats['age_group'] = 'senior'
  end
end



















