# frozen_string_literal: true

require_relative 'treasure_trove'
require_relative 'die'
require_relative 'playable'

module StudioGame
  class Player
    include Playable
    attr_accessor :treasures, :health, :name

    def initialize(name, health = 100)
      @name = name.capitalize
      @health = health
      @treasures = Hash.new(0)
    end

    def to_s
      "I'm #{@name} with health of #{@health} and score of #{score}"
    end

    def self.from_csv(txt)
      name, health = txt.split(',')
      Player.new(name, Integer(health))
    end

    def name=(new_name)
      @name = new_name.capitalize
    end

    #     ##################################################
    #     Treasure methods
    #     ##################################################
    def get_treasure(specific_treasure = nil)
      treasure = specific_treasure.nil? ? TreasureTrove.random.dup : specific_treasure
      puts "#{name} Found treasure! #{treasure.name} worth #{treasure.points}"
      store_treasure(treasure)
    end

    def store_treasure(treasure)
      if @treasures.key?(treasure.name.to_sym)
        @treasures[treasure.name.to_sym] += treasure.points
      else
        @treasures[treasure.name.to_sym] = treasure.points
      end
    end

    def found_treasure?
      die = Die.new(8)
      die.roll > 5
    end

    def score
      @health += points
    end

    def points
      @treasures.values.reduce(0, :+)
    end

    def inventory
      return unless @treasures.size > 1

      puts "#{@name} has the following treasures".ljust(60, '_')
      each_found_treasure do |treasure|
        puts treasure.name.to_s.ljust(25, '.') + "#{treasure.points} \n"
      end
      puts 'Total'.ljust(25, '.') + "#{@player.points} \n"
      puts "\n"
    end

    def each_found_treasure
      return unless @treasures.size > 1

      @treasures.each do |name, points|
        treasure = Treasure.new(name, points)

        yield treasure
      end
    end
  end

  if __FILE__ == $PROGRAM_NAME

    # Testing section
    player1 = Player.new('moe')
    player2 = Player.new('larry', 60)
    player3 = Player.new('curly', 125)
    player4 = Player.new('sHeMp', 85)

    players = [player1, player2, player3, player4]

    players.each do |player|
      player.get_treasure
      puts player.inventory
      puts player
      puts player.treasures
    end

  end
end
