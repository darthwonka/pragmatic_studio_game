# frozen_string_literal: true

require 'rspec'
require 'studio_game/spec_helper'
require 'studio_game/player_clumsy'
# $stdout = StringIO.new
module StudioGame
  describe 'clumsy players' do
    before do
      # $stdout = StringIO.new
      @initial_health = 150
    end

    it 'treasures are worth half of their value' do
      player = ClumsyPlayer.new('geoff', @initial_health, 3)
      player.get_treasure(TreasureTrove.random(:hammer).dup)
      expect(player.treasures[:hammer]).to eq(25)
    end
  end
end
