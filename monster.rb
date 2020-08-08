class Monster
  attr_accessor :name, :race, :max_health, :current_health, :source_file

  def initialize(name:, race:, max_health:, source_file: nil)
    @name = name
    @race = race
    @max_health = max_health
    @source_file = source_file

    @health = @max_health
  end
end
