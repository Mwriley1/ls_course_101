#1. An error? (Will be returned as nil, gotcha.)

#2. greetings' value will change to {a: 'hi there'}

greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings

#3. 

#A. one = 'one', two = 'two', three = 'three'
#B. one = 'one', two = 'two', three = 'three'
#C. one = 'two', two = 'three', three = 'one'

=begin
def mess_with_vars(one, two, three)
  one = two
  two = three
  three = one
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"

def mess_with_vars(one, two, three)
  one = "two"
  two = "three"
  three = "one"
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"

=end

def mess_with_vars(one, two, three)
  one.gsub!("one","two")
  two.gsub!("two","three")
  three.gsub!("three","one")
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"

#4. 

def generate_UUID
  characters = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'a', 'b', 'c', 'd', 'e', 'f']
  uuid = []
  32.times do |num|
    uuid << characters.sample 
    case uuid.length
    when 8
      uuid << '-'
    when 13
      uuid << '-'
    when 18
      uuid << '-'
    when 23
      uuid << '-'
    end
  end
  uuid.join
end

p generate_UUID

#5.

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  while dot_separated_words.size > 0 && dot_separated_words.size < 5 do
    word = dot_separated_words.pop
    return false unless is_a_number?(word)
  end
  true
end



