require_relative 'encounter'
require 'json'

ENCOUNTERS_DIRECTORY = 'data/encounters'.freeze

def put_encounter_name(encounter_path)
  encounter_being_checked = JSON.parse(File.read("#{encounter_path}"))
  encounter_being_checked["name"]
end

def get_integer_in_range(maximum, minimum:0)
  input = gets.strip
  if input.to_i.to_s != input
    puts "Please enter a whole number"
    get_integer_in_range(maximum, minimum:minimum)
  elsif (input.to_i < minimum) or (input.to_i > maximum)
    puts "please enter a number between #{minimum} and #{maximum} (inclusive)."
    get_integer_in_range(maximum, minimum:minimum)
  else
    input.to_i
  end
end

filenames = Dir["#{ENCOUNTERS_DIRECTORY}/*.json"]

encounter_names = filenames.map {
  |file_path|
  put_encounter_name(file_path)
}

puts "Please select an encounter from the list:"

encounter_names.length.times {
  |item_index|
  puts "#{item_index}: #{encounter_names[item_index]}"
}

selected_index = get_integer_in_range(encounter_names.length-1)

puts filenames[selected_index]
