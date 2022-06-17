# frozen_string_literal: true

require 'rspec'
require 'studio_game/spec_helper'
require 'studio_game/game'
require 'studio_game/player'
module StudioGame
  describe 'setup game' do
    before do
      $stdout = StringIO.new
      @initial_health = 150
      # create an array of players
      @game = Game.new('knuckleheads')
      @player1 = Player.new('moe', 100)
      @player2 = Player.new('larry', 200)
      @player3 = Player.new('curly', 300)
      @berserker = BerserkPlayer.new('zod', 100)
      @clumsy  = ClumsyPlayer.new('zod', 100)
      @players = [@player1, @player2, @player3, @berserker, @clumsy]
      @players.each do |player|
        @game.add_player(player)
      end
    end

    it 'game object exists' do
      expect(@game.title).to eq('Knuckleheads')
    end
    it 'has players' do
      expect(@game.players.size).to be > 1
    end

    it 'should w00t when a high number is rolled' do
      allow_any_instance_of(Die).to receive(:roll).and_return(5)
      prior_health = @player1.health

      @game.play(1)
      expect(@player1.health).to be == prior_health + 15
    end

    it 'should Blam when a low number is rolled' do
      allow_any_instance_of(Die).to receive(:roll).and_return(1)
      current_health = @player1.health
      @game.play(1)
      expect(@player1.health).to be == current_health - 10
    end

    it 'should sort by decreasing score' do
      expect(@players.sort.should) == [@berserker, @clumsy, @player3, @player2, @player1]
    end

    it 'berserkers get all w00t after 5 w00ts' do
      allow_any_instance_of(Die).to receive(:roll).and_return(1)
      5.times { @berserker.w00t }

      5.times do
        prior_health = @berserker.health
        @game.play(1)
        expect(@berserker.health).to be(prior_health + 15)
      end
    end
  end
end
