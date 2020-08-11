# frozen_string_literal: true

require 'json'

SAFE_FILENAME_CHARACTERS = /[\w-]/.freeze
ENCOUNTERS_DIRECTORY = 'data/encounters'

def sanitize_filename(filename, extension:)
  filename = filename.downcase.gsub(' ', '-')
  sanitized_filename = filename.scan(SAFE_FILENAME_CHARACTERS).join
  "#{sanitized_filename}.#{extension}"
end

# Ask for encounter name
puts 'Encounter Name:'
encounter_name = gets.chomp

# Assemble encounter data
encounter_data = { name: encounter_name }

# Create JSON file
encounter_filename = sanitize_filename(encounter_name, extension: 'json')
encounter_file_destination = "#{ENCOUNTERS_DIRECTORY}/#{encounter_filename}"
File.write(encounter_file_destination, encounter_data.to_json)

puts encounter_filename
