class Monster
  attr_accessor :name, :race, :max_health, :current_health, :encounter_file

  def initialize(name:, race:, max_health:, encounter_file: nil)
    @name = name
    @race = race
    @max_health = max_health
    @encounter_file = encounter_file

    @health = @max_health
  end

  def data
    { name: name, race: race, max_health: max_health, current_health: current_health }
  end
end
