require_relative 'monster'

require 'active_support/core_ext/string'
require 'json'

class Encounter
  attr_accessor :name, :monsters, :encounter_file

  def initialize(encounter_file = nil, name: nil)
    self.encounter_file = encounter_file
    self.monsters = []

    load_from_encounter_file

    self.name = name if name.present?
  end

  def monster_names
    monsters.map { |monster| monster.name }
  end

  def data
    monster_data = monsters.map(&:data)
    { name: name, monsters: monster_data }
  end

  private

  def load_from_encounter_file
    return if encounter_file.blank?

    encounter_json = File.read(encounter_file)
    encounter_data = JSON.parse(encounter_json)

    monsters = encounter_data['monsters'].map do |monster_data|
      name, race, max_health = monster_data.values_at('name', 'race', 'max_health')
      Monster.new(name: name, race: race, max_health: max_health, encounter_file: encounter_file)
    end

    self.name = encounter_data['name']
    self.monsters.concat(monsters)
  end
end
