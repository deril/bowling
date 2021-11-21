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

  context 'when rolling 10,10,10' do
    it 'scores to 60' do
      [10, 10, 10].each { |pins| subject.roll(pins) }

      expect(subject.score).to eq 60
    end
  end

  context 'when rolling 10,4,0' do
    it 'scores to 14' do
      [10, 4, 0].each { |pins| subject.roll(pins) }

      expect(subject.score).to eq 18
    end
  end

  context 'when rolling a spare' do
    it 'scores to 16' do
      [5, 5, 3].each { |pins| subject.roll(pins) }

      expect(subject.score).to eq 16
    end
  end

  context 'when rolling a strike' do
    it 'scores to 24' do
      [10, 3, 4].each { |pins| subject.roll(pins) }

      expect(subject.score).to eq 24
    end
  end

  context 'when rolling a perfect game' do
    it 'scores to 300' do
      [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10].each { |pins| subject.roll(pins) }

      expect(subject.score).to eq 300
    end
  end

  context 'when rolling a strike and a spare' do
    it 'scores to 36' do
      [10, 5, 5, 3].each { |pins| subject.roll(pins) }

      expect(subject.score).to eq 36
    end
  end

  context 'when rolling a strike and a spare and a strike' do
    it 'scores to 46' do
      [10, 5, 5, 3, 0, 10].each { |pins| subject.roll(pins) }

      expect(subject.score).to eq 46
    end
  end

  context 'when rolling a strike and a spare and a strike and a spare' do
    it 'scores to 82' do
      [10, 5, 5, 3, 0, 10, 5, 5, 3, 0, 10].each { |pins| subject.roll(pins) }

      expect(subject.score).to eq 82
    end
  end

  context 'when rolling a strike and a spare and a strike and a spare and a strike' do
    it 'scores to 102' do
      [10, 5, 5, 3, 0, 10, 5, 5, 3, 0, 10, 10].each { |pins| subject.roll(pins) }

      expect(subject.score).to eq 102
    end
  end

  context 'when rolling a strike and a spare and a strike and a spare and a strike and a spare' do
    it 'scores to 127' do
      [10, 5, 5, 3, 0, 10, 5, 5, 3, 0, 10, 10, 5, 5].each { |pins| subject.roll(pins) }

      expect(subject.score).to eq 127
    end
  end

  context 'when rolling a normal game' do
    it 'scores to 133' do
      [1, 4, 4, 5, 6, 4, 5, 5, 10, 0, 1, 7, 3, 6, 4, 10, 2, 8, 6].each { |pins| subject.roll(pins) }

      expect(subject.score).to eq 133
    end
  end
end
