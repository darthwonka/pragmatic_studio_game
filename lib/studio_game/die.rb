# frozen_string_literal: true

require_relative 'auditable'

module StudioGame
  class Die
    include Auditable

    attr_reader :number

    def initialize(sides = 6)
      @sides = sides
      roll
    end

    def roll
      @number = rand(1..@sides)
      audit
      @number
    end
  end
end
