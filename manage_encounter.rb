# frozen_string_literal: true

require 'active_support/core_ext/string'
require 'json'

SAFE_FILENAME_CHARACTERS = /[\w-]/.freeze
ENCOUNTERS_DIRECTORY = 'data/encounters'

def sanitize_filename(base_name, extension: nil)
  base_name = base_name.downcase.gsub(' ', '-')
  sanitized_filename = base_name.scan(SAFE_FILENAME_CHARACTERS).join

  return unless sanitized_filename.present?
  sanitized_filename << ".#{extension}" if extension.present?
  puts ''

  sanitized_filename
end

def encounter_name_valid? encounter_name
  sanitized_name = sanitize_filename(encounter_name)
  sanitized_name.present?
end

def request_encounter_name(message)
  puts message
  encounter_name = gets.chomp

  if encounter_name_valid? encounter_name
    encounter_name
  else
    request_encounter_name('Invalid encounter name. Please try again.')
  end
end

# Collect encounter data
encounter_name = request_encounter_name('Encounter Name:')
encounter_data = { name: encounter_name }

# Create JSON file
encounter_filename = sanitize_filename(encounter_name, extension: 'json')
encounter_file_destination = "#{ENCOUNTERS_DIRECTORY}/#{encounter_filename}"
File.write(encounter_file_destination, encounter_data.to_json)

puts encounter_filename
