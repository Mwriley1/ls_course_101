#1. It would output 1 2 2 3

#2. The ! operator can represent a logical 'not' or 'opposite' or signify a change/side effect of a particalur method.  The ? can represent a logical if or signify the return of a boolean in a method.
#   != represents the logical 'not equal to.' It should be used in conditional statements.
#   ! returns the opposite of an objects boolean return
#   !! returns an objects boolean return

#3.

advice = "Few things in life are as important as house training your pet dinosaur."
puts advice
advice.gsub!('important','urgent')
puts advice

#4.  numbers.delete_at(1) will remove an element from an array at index 1.
#. numbers.delete(1) will remove the element equal to 1 from the array.

#5.

puts (10..100).cover?(42)

#6.

famous_words = "seven years ago..."
puts famous_words

famous_words.insert(0,'Four score and ')
puts famous_words

famous_words = "seven years ago..."
puts famous_words

puts 'Four score and ' + famous_words

#7. 

def add_eight(number)
  number + 8
end

number = 2

how_deep = "number"
5.times { how_deep.gsub!("number", "add_eight(number)") }

p how_deep

p eval(how_deep)

#8.

flintstones = ['Fred', 'Wilma', ['Barney', 'Betty'], ['BamBam', 'Pebbles']]
p flintstones.flatten!

#9.

flintstones_hash = {'Fred' => 0, 'Wilma' => 1, 'Barney' => 2, 'Betty' => 3, 'BamBam' => 4, 'Pebbles' => 5}
flintstones_hash.delete_if {|key, value| value != 2}
p flintstones_hash.flatten

p flintstones_hash = {'Fred' => 0, 'Wilma' => 1, 'Barney' => 2, 'Betty' => 3, 'BamBam' => 4, 'Pebbles' => 5}
p flintstones_hash.assoc("Barney")

#10.

flintstones_2 = ['Fred', 'Barney', 'Wilma', 'Betty', 'Pebbles', 'BamBam']
flintstones_hash_2 = {}
flintstones_2.each_with_index do |name, index|
  flintstones_hash_2[name] = index
end

p flintstones_hash_2







