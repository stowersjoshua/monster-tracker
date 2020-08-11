require 'active_support/core_ext/string'
require 'json'

SAFE_FILENAME_CHARACTERS = /[\w-]/.freeze
ENCOUNTERS_DIRECTORY = 'data/encounters'.freeze

@encounter_data = { monsters: [] }

def write_encounter_file(encounter_data)
  encounter_name = encounter_data[:name]
  encounter_filename = sanitize_filename(encounter_name, extension: 'json')
  encounter_file_destination = "#{ENCOUNTERS_DIRECTORY}/#{encounter_filename}"
  File.write(encounter_file_destination, encounter_data.to_json)

  puts "Printed encounter info to ./#{encounter_file_destination}"
end

def sanitize_filename(base_name, extension: nil)
  base_name = base_name.downcase.gsub(' ', '-')
  sanitized_filename = base_name.scan(SAFE_FILENAME_CHARACTERS).join

  return unless sanitized_filename.present?
  sanitized_filename << ".#{extension}" if extension.present?

  sanitized_filename
end

def encounter_name_valid? encounter_name
  sanitized_name = sanitize_filename(encounter_name)
  sanitized_name.present?
end

def request_encounter_name(message = 'Encounter Name:')
  puts message
  encounter_name = gets.chomp

  if encounter_name_valid? encounter_name
    encounter_name
  else
    request_encounter_name('Invalid encounter name. Please try again.')
  end
end

def request_monster_name
  puts 'Monster Name:'
  gets.chomp
end

def request_monster_race
  previous_monster = @encounter_data[:monsters].last
  default_race = previous_monster&.fetch(:race)

  message = 'Monster Race:'
  message << " (Default #{default_race})" if default_race.present?

  puts message
  gets.chomp
end

def request_monster_max_health(message = 'Max Health:')
  puts message
  max_health = gets.chomp
  max_health = max_health.scan(/\d+/).first.to_i

  if max_health.present?
    max_health
  else
    request_monster_max_health('Invalid input. Please try again.')
  end
end

def request_new_monster_data
  monster_name = request_monster_name
  monster_race = request_monster_race
  monster_max_health = request_monster_max_health
  { name: monster_name, race: monster_race, max_health: monster_max_health }
end

encounter_name = request_encounter_name
@encounter_data[:name] = encounter_name

monster_data = request_new_monster_data
@encounter_data[:monsters] << monster_data

write_encounter_file(@encounter_data)
