# frozen_string_literal: true

class Frame
  def initialize
    @rolls = []
  end

  def hit_pins(pins)
    validate!(pins)

    @rolls << pins
  end

  def score
    if strike?
      10 + second_roll + third_roll
    elsif spare?
      10 + third_roll
    else
      first_roll + second_roll
    end
  end

  def complete?
    strike? || spare? || rolls.size == 2
  end

  def strike?
    first_roll == 10
  end

  def spare?
    return false if strike?

    first_roll + second_roll == 10
  end

  def active?
    rolls.size < 2 || ((strike? || spare?) && rolls.size < 3)
  end

  private

  attr_reader :rolls

  def first_roll
    rolls[0] || 0
  end

  def second_roll
    rolls[1] || 0
  end

  def third_roll
    rolls[2] || 0
  end

  def validate!(pins)
    validate_pins(pins)
    validate_roll_after_strike
    validate_roll_after_spare
    validate_normal_roll
  end

  def validate_pins(pins)
    raise InvalidRoll, 'Cannot roll more than 10 pins' if pins > 10
    raise InvalidRoll, 'Cannot roll less than 0 pins' if pins.negative?
    raise InvalidRoll, 'Cannot roll more than 10 pins' if !complete? && pins + first_roll > 10
  end

  def validate_roll_after_strike
    raise InvalidRoll, 'Cannot roll a strike after the bonus two rolls' if strike? && rolls.size == 3
  end

  def validate_roll_after_spare
    raise InvalidRoll, 'Cannot roll a spare after the bonus roll' if spare? && rolls.size == 3
  end

  def validate_normal_roll
    raise InvalidRoll, 'Cannot roll more than twice' if !strike? && !spare? && rolls.size == 2
  end

  InvalidRoll = Class.new(StandardError)
end
