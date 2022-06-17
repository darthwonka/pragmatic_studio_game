# frozen_string_literal: true

require_relative 'player'


module StudioGame
  class BerserkPlayer < Player
    LEVEL = [20, 15, 10, 5].freeze

    def initialize(name, health, lvl = 3)
      super(name, health)
      puts "level is #{LEVEL[lvl]} for berserker #{name}"
      @rage = (LEVEL[lvl]).to_i
      @poker = 0
    end

    def berserk?
      @poker >= @rage
    end

    def w00t
      puts "#{name} is berserk!" if berserk?
      @poker += 1
      super
    end

    def blam
      berserk? ? w00t : super
    end

    def self.from_csv(txt)
      name, health, level, _type = txt.split(',')
      BerserkPlayer.new(name, Integer(health), Integer(level))
    end
  end
end
