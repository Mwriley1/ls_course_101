#1. 

ages = {'Herman' => 32, 'Lily' => 30, 'Grandpa' => 402, 'Eddie' => 10}
p ages.include?('Spot')
p ages.key?('Spot')
p ages.has_key?('Spot')

#2. 

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
sum_ages = 0
ages.each_value {|value| sum_ages += value}

p sum_ages

p ages.values.inject(:+)

#3. 

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

ages.delete_if {|_key, value| value >= 100}
p ages

#4. 

munsters_description = "The Munsters are creepy in a good way."

p munsters_description
p munsters_description.capitalize!
p munsters_description.swapcase!
p munsters_description.downcase!
p munsters_description.upcase!

#5. 

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
additional_ages = { "Marilyn" => 22, "Spot" => 237 }
ages.merge!(additional_ages)

p ages

#6. 

p ages.values.min

#7.

advice = "Few things in life are as important as house training your pet dinosaur."
p advice.include?('Dino')
p advice.match('Dino')

#8.

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones.find_index {|name| name.start_with?('Be')}

#9.

flintstones.map! do |name|
  name[0,3]
end

#10. 

p flintstones.map! {|name| name[0,3]}














