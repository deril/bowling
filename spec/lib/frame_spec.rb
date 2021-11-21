# frozen_string_literal: true

require 'spec_helper'

describe Frame do
  let(:frame) { Frame.new }

  it 'scores 0 on initialize' do
    expect(frame.score).to eq 0
  end

  shared_examples 'a strike' do
    it 'returns true on strike?' do
      expect(frame.strike?).to be true
    end

    it 'returns false on spare?' do
      expect(frame.spare?).to be false
    end

    it 'returns false on complete?' do
      expect(frame.complete?).to be true
    end
  end

  shared_examples 'a spare' do
    it 'returns false on strike?' do
      expect(frame.strike?).to be false
    end

    it 'returns true on spare?' do
      expect(frame.spare?).to be true
    end

    it 'returns false on complete?' do
      expect(frame.complete?).to be true
    end
  end

  context 'when a strike is rolled' do
    before do
      frame.hit_pins(10)
    end

    it 'scores 10' do
      expect(frame.score).to eq 10
    end

    context 'when a second roll is rolled' do
      before do
        frame.hit_pins(5)
      end

      it 'scores 15' do
        expect(frame.score).to eq 15
      end

      it_behaves_like 'a strike'

      context 'when a third roll is rolled' do
        before do
          frame.hit_pins(5)
        end

        it 'scores 20' do
          expect(frame.score).to eq 20
        end

        it_behaves_like 'a strike'
      end
    end
  end

  context 'when a spare is rolled' do
    before do
      frame.hit_pins(5)
      frame.hit_pins(5)
    end

    it 'scores 10' do
      expect(frame.score).to eq 10
    end

    it_behaves_like 'a spare'

    context 'when a second roll is rolled' do
      before do
        frame.hit_pins(5)
      end

      it 'scores 15' do
        expect(frame.score).to eq 15
      end

      it_behaves_like 'a spare'
    end
  end

  context 'when validation errors' do
    it 'raises an error when a roll is attempted with negative pins' do
      expect { frame.hit_pins(-1) }.to raise_error(Frame::InvalidRoll)
    end

    it 'raises an error when a roll is attempted with more than 10 pins' do
      expect { frame.hit_pins(11) }.to raise_error(Frame::InvalidRoll)
    end

    it 'raises an error when a fourth roll is attempted for strike' do
      frame.hit_pins(10)
      frame.hit_pins(5)
      frame.hit_pins(5)
      expect { frame.hit_pins(5) }.to raise_error(Frame::InvalidRoll)
    end

    it 'raises an error when a fourth roll is attempted for spare' do
      frame.hit_pins(5)
      frame.hit_pins(5)
      frame.hit_pins(5)
      expect { frame.hit_pins(5) }.to raise_error(Frame::InvalidRoll)
    end

    it 'raises an error when a roll is attempted after the frame is complete' do
      frame.hit_pins(4)
      frame.hit_pins(3)
      expect { frame.hit_pins(5) }.to raise_error(Frame::InvalidRoll)
    end

    it 'raises an error when an impossible roll' do
      frame.hit_pins(4)
      expect { frame.hit_pins(7) }.to raise_error(Frame::InvalidRoll)
    end
  end

  context 'when a normal roll is made' do
    before do
      frame.hit_pins(5)
      frame.hit_pins(3)
    end

    it 'scores 8' do
      expect(frame.score).to eq 8
    end

    it 'returns false on strike?' do
      expect(frame.strike?).to be false
    end

    it 'returns false on spare?' do
      expect(frame.spare?).to be false
    end

    it 'returns true on complete?' do
      expect(frame.complete?).to be true
    end
  end

  describe '#active_frame?' do
    context 'when the frame is an active frame' do
      context 'when frame is strike' do
        before do
          frame.hit_pins(10)
        end

        it 'returns true' do
          expect(frame.active?).to be true
        end

        context 'when with 1 bonus roll' do
          before do
            frame.hit_pins(5)
          end

          it 'returns true' do
            expect(frame.active?).to be true
          end

          context 'when with 2 bonus rolls' do
            before do
              frame.hit_pins(5)
            end

            it 'returns true' do
              expect(frame.active?).to be false
            end
          end
        end
      end

      context 'when frame is spare' do
        before do
          frame.hit_pins(5)
          frame.hit_pins(5)
        end

        it 'returns true' do
          expect(frame.active?).to be true
        end

        context 'when with 1 bonus roll' do
          before do
            frame.hit_pins(5)
          end

          it 'returns true' do
            expect(frame.active?).to be false
          end
        end
      end

      context 'when frame has one roll' do
        before do
          frame.hit_pins(5)
        end

        it 'returns true' do
          expect(frame.active?).to be true
        end
      end
    end

    context 'when the frame is not an active' do
      before do
        frame.hit_pins(5)
        frame.hit_pins(3)
      end

      it 'returns false' do
        expect(frame.active?).to be false
      end
    end
  end
end
