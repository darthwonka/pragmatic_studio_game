# frozen_string_literal: true

module Playable
  def strong?
    health > 100
  end

  def <=>(other)
    other.score <=> score
  end

  def w00t
    self.health += 15
    "#{name} got w00ted!"
  end

  def blam
    self.health -= 10
    "#{name} got blammed!"
  end

  def badstuff(loss, treasure)
    badthings = [
      "Dropped the #{treasure.name} on the floor",
      "Dinged the #{treasure.name} on a protruding rock",
      "Dog lifted it's leg and pissed on #{name}'s #{treasure.name}",
      "#{name}'s #{treasure.name} fell down the stairs and scared the cat",
      "#{name} sat on the #{treasure.name} and cracked it"
    ]
    depreciate = "Costing #{name} #{loss} points"

    "#{badthings[rand(1..5)]}!\n#{depreciate} "
  end
end
