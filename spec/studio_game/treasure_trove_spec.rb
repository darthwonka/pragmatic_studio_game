# frozen_string_literal: true

require 'studio_game/treasure_trove'
module StudioGame
  describe TreasureTrove do
    it 'has six treasures' do
      expect(TreasureTrove::TREASURES.size).to be == 6
    end

    it 'has a pie worth 5 points' do
      expect(TreasureTrove::TREASURES[:pie].points).to be == 5
    end

    it 'has a bottle worth 25 points' do
      expect(TreasureTrove::TREASURES[:bottle].points).to be == 25
    end

    it 'has a hammer worth 50 points' do
      expect(TreasureTrove::TREASURES[:hammer].points).to be == 50
    end

    it 'has a skillet worth 100 points' do
      expect(TreasureTrove::TREASURES[:skillet].points).to be == 100
    end

    it 'has a broomstick worth 200 points' do
      expect(TreasureTrove::TREASURES[:broomstick].points).to be == 200
    end

    it 'has a crowbar worth 400 points' do
      expect(TreasureTrove::TREASURES[:crowbar].points).to be == 400
    end

    it 'can give me a random treasure' do
      treasure = TreasureTrove.random
      expect(treasure).to be_a_kind_of(Treasure)
    end
  end
end
