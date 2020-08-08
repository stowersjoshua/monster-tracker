require_relative 'encounter'

encounter_file_location = 'data/encounters/encounter-1.json'
encounter = Encounter.new(encounter_file_location)

puts "Encounter Name: #{encounter.name}"
puts "Monster Names: #{encounter.monster_names.join(', ')}"
