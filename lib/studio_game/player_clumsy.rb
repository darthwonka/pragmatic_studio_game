# frozen_string_literal: true

require_relative 'player'

module StudioGame
  class ClumsyPlayer < Player
    LEVEL = [0.95, 0.90, 0.75, 0.50].freeze

    def initialize(name, health, lvl = 3)
      super(name, health)
      @damage = [1..3].include?(lvl) ? LEVEL[lvl] : LEVEL[3]
    end

    def get_treasure(specific_treasure = nil)
      treasure = specific_treasure.nil? ? TreasureTrove.random.dup : specific_treasure
      orig = treasure.points
      newvalue = (treasure.points * @damage).to_i
      treasure.points = newvalue
      puts badstuff(orig - newvalue, treasure)
      super(treasure)
    end

    def each_found_treasure
      return unless @treasures.size > 1

      @treasures.each do |name, points|
        treasure = Treasure.new(name, points.to_i)
        yield treasure
      end
    end

    def self.from_csv(txt)
      name, health, level, _type = txt.split(',')
      ClumsyPlayer.new(name, Integer(health), Integer(level))
    end
  end
end
