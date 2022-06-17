# frozen_string_literal: true

require 'rspec'
require 'studio_game/spec_helper'
require 'studio_game/player'
# $stdout = StringIO.new
module StudioGame
  describe 'Created with initial health of 150' do
    before do
      # $stdout = StringIO.new
      @initial_health = 150
      @player = Player.new('larry', @initial_health)
      @player.treasures.merge!({ hammer: 50 })  { |_key, old_points, new_points| old_points + new_points }
      @player.treasures.merge!({ toiletseat: 25 }) { |_key, old_points, new_points| old_points + new_points }
      @player.treasures.merge!({ knife: 200 })  { |_key, old_points, new_points| old_points + new_points }
    end

    it 'has a capitalized name' do
      expect(@player.name).to eq('Larry')
    end
    it 'has a string representation' do
      expect(@player.to_s).to be_a(String)
    end
    it 'computes a score as the sum of its health and the value of treasures collected' do
      total = [150, 50, 25, 200].sum
      expect(@player.score).to eq(total)
    end
    it 'increases health by 15 when w00ted' do
      @player.w00t
      expect(@player.health.to_i).to eq(@initial_health + 15)
    end
    it 'decreases health by 10 when blammed' do
      @player.blam
      expect(@player.health.to_i).to eq(@initial_health - 10)
    end

    it 'Yields each found treasure and its total points' do
      yielded = []
      expecting = []
      @player.each_found_treasure do |treasure|
        yielded << treasure
      end

      test_treasures = {
        hammer: 50,
        toiletseat: 25,
        knife: 200
      }
      test_treasures.each do |name, value|
        treasure = Treasure.new(name, value)
        expecting << treasure
      end
      expect(yielded).to match_array(expecting)
    end
  end
  describe 'Created with default health' do
    before do
      @player = Player.new('moe')
    end

    it 'has an initial health' do
      expect(@player.health).to_not be_nil
    end
  end

  describe 'Playing the game' do
    before do
      @initial_health = 150
      @player = Player.new('shrek', @initial_health)
    end

    it 'is a strong player' do
      expect(@player).to be_strong
    end
  end

  describe 'Utilities' do
    before do
    end

    it 'can create players from csv format' do
      csv = 'ziggy,110'
      player = Player.from_csv(csv)
      expect(player).to be_kind_of Player
    end
  end
end
