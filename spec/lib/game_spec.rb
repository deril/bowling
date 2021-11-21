# frozen_string_literal: true

require 'spec_helper'

describe Game do
  subject { Game.new }

  context 'when rolling 1,3,6,3' do
    it 'scores to 13' do
      [1, 3, 6, 3].each { |pins| subject.roll(pins) }

      expect(subject.score).to eq 13
    end
  end
end
