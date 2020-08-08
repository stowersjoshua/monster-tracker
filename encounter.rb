require 'json'

class Encounter
  attr_accessor :name

  def initialize(encounter_file_location)
    encounter_file = File.read(encounter_file_location)
    encounter_json = JSON.parse(encounter_file)

    @name = encounter_json["name"]
  end
end
