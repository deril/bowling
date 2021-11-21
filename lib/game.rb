# frozen_string_literal: true

class Game
  def initialize
    @frames = [Frame.new]
  end

  def roll(pins)
    active_frames.each do |frame|
      frame.hit_pins(pins)
    end
    add_frame
  end

  def score
    frames.map(&:score).reduce(:+)
  end

  private

  def add_frame
    return if frames.size == 10

    frames << Frame.new if frames.last&.complete?
  end

  attr_reader :frames

  def active_frames
    frames.select(&:active?)
  end
end
