# frozen_string_literal: true

require_relative 'die'

module GameTurn
  def self.take_turn(player)
    die = StudioGame::Die.new(6)
    case die.roll

    when 5..6
      player.w00t
    when 1..2
      player.blam
    end
  end
end
