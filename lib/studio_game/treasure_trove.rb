# frozen_string_literal: true

Treasure = Struct.new(:name, :points)
module TreasureTrove
  TREASURES = {
    pie: Treasure.new('pie', 5),
    bottle: Treasure.new('bottle', 25),
    hammer: Treasure.new('hammer', 50),
    skillet: Treasure.new('skillet', 100),
    broomstick: Treasure.new('broomstick', 200),
    crowbar: Treasure.new('crowbar', 400)
  }.freeze

  def self.list
    puts 'Treasures abound!'.center(50, '_')
    TREASURES.each do |name, treasure|
      puts name.to_s.to_s.ljust(30, '.') + "#{treasure.points} \n"
    end
  end

  def self.list_to_hash
    treasures_hash = {}
    TREASURES.each do |name, _treasure|
      treasures_hash[name.to_sym] = 0
    end
    treasures_hash
  end

  def self.to_hash(treasure)
    { treasure.name.to_sym => treasure.points }
  end

  def self.random(item_key = nil)
    key = item_key.nil? ? TREASURES.keys.sample : item_key
    TREASURES[key.to_sym]
  end
end
