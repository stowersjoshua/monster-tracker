require_relative 'encounter'
require 'json'

ENCOUNTERS_DIRECTORY = 'data/encounters'.freeze
ENCOUNTER_FILES = Dir["#{ENCOUNTERS_DIRECTORY}/*.json"].freeze

def put_encounter_name(encounter_file)
  file_raw_json = File.read(encounter_file.to_s)
  encounter_being_checked = JSON.parse(file_raw_json)
  encounter_being_checked["name"]
end

def get_integer_in_range(maximum, minimum: 1)
  input = gets.strip
  if input.to_i.to_s != input
    puts "Please enter a whole number"
    get_integer_in_range(maximum, minimum: minimum)
  elsif (input.to_i < minimum) or (input.to_i > maximum)
    puts "please enter a number between #{minimum} and #{maximum} (inclusive)."
    get_integer_in_range(maximum, minimum: minimum)
  else
    input.to_i
  end
end

encounter_names = ENCOUNTER_FILES.map do |file_path|
  put_encounter_name(file_path)
end

puts "Please select an encounter from the list:"

encounter_names.each.with_index(1) do |encounter_name, index|
  puts "#{index}: #{encounter_name}"
end

selected_index = get_integer_in_range(encounter_names.length)-1

puts ENCOUNTER_FILES[selected_index]
