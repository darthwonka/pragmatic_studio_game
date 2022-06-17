# frozen_string_literal: true

require 'rspec'
require 'studio_game/spec_helper'
require 'studio_game/player_berserk'
# $stdout = StringIO.new
module StudioGame
  describe 'Berserk players' do
    before do
      # $stdout = StringIO.new
      @initial_health = 150
    end

    it 'Does not go berserk before 5 times' do
      player = BerserkPlayer.new('neil', @initial_health, 3)
      4.times { player.w00t }
      score = player.score
      player.blam
      expect(player.score).to be(score - 10)
    end

    it 'Gets all w00ts after 5 w00ts' do
      player = BerserkPlayer.new('geoff', @initial_health, 3)
      5.times do
        player.w00t
      end
      prior_score = player.score
      player.blam
      player.blam

      expect(player.score).to be(prior_score + 30)
    end

    it 'is a berserker after 5 woots' do
      player = BerserkPlayer.new('geoff', @initial_health, 3)
      5.times { player.w00t }
      expect(player.berserk?).to be true
    end
  end
end
