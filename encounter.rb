require 'json'
require_relative 'monster'

class Encounter
  attr_accessor :name, :monsters

  def initialize(source_file)
    encounter_file = File.read(source_file)
    encounter_json = JSON.parse(encounter_file)

    @name = encounter_json["name"]
    @monsters = []

    encounter_json["monsters"].each do |monster_data|
      name, race, max_health = monster_data.values_at("name", "race", "max_health")
      monster = Monster.new(name: name, race: race, max_health: max_health, source_file: source_file)
      @monsters.append(monster)
    end
  end

  def monster_names
    monsters.map { |monster| monster.name }
  end
end
