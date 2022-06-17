# frozen_string_literal: true

module Auditable
  def audit
    puts "Rolled #{number} (#{number.class})"
  end
end
