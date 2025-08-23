require 'stringio'
require_relative '../../app/lib/guessing_game'

RSpec.describe GuessingGame do
  describe '#play' do
    let(:input) { StringIO.new }
    let(:output) { StringIO.new }
    let(:random) { instance_double(Random, rand: guess) }

    def play_with_attempts(attempts)
      allow(input).to receive(:gets).exactly(attempts.size).times.and_return(*attempts)
      GuessingGame.new(input: input, output: output, random: random).play
      output.string.lines.map(&:chomp)
    end

    context 'when gamer win on first attempt' do
      let(:guess) { 34 }
      let(:attempts) { ['34'] }

      it 'exits on the first guess if it is correct' do
        lines = play_with_attempts(attempts)

        expect(lines[0]).to eq 'Pick a number 1-100 (5 guesses left):'
        expect(lines[1]).to eq 'You won!'
        expect(lines.size).to eq 2
      end
    end

    context 'when gamer win on second attempt and fist try is too high' do
      let(:guess) { 34 }
      let(:attempts) { ['55', '34'] }

      it 'exits on the second guess and say is too high in first attempt' do
        lines = play_with_attempts(attempts)

        expect(lines).to eq [
                              'Pick a number 1-100 (5 guesses left):',
                              '55 is too high!',
                              'Pick a number 1-100 (4 guesses left):',
                              'You won!'
                            ]
      end
    end

    context 'when gamer win on second attempt and fist try is too low' do
      let(:guess) { 34 }
      let(:attempts) { ['1', '34'] }

      it 'exits on the second guess say is too low in first attempt' do
        lines = play_with_attempts(attempts)

        expect(lines).to eq [
                              'Pick a number 1-100 (5 guesses left):',
                              '1 is too low!',
                              'Pick a number 1-100 (4 guesses left):',
                              'You won!'
                            ]
      end
    end

    context 'when the player miss the 5 tries' do
      let(:guess) { 34 }
      let(:attempts) { ['1', '90', '3', '33', '77'] }

      it 'exists on the fifth guess and print you lost with the correct guess' do
        lines = play_with_attempts(attempts)

        expect(lines).to eq [
                              'Pick a number 1-100 (5 guesses left):',
                              '1 is too low!',
                              'Pick a number 1-100 (4 guesses left):',
                              '90 is too high!',
                              'Pick a number 1-100 (3 guesses left):',
                              '3 is too low!',
                              'Pick a number 1-100 (2 guesses left):',
                              '33 is too low!',
                              'Pick a number 1-100 (1 guesses left):',
                              '77 is too high!',
                              'You lost! The number was: 34'
                            ]
      end
    end

    context 'when the player wins in the 5th try' do
      let(:guess) { 34 }
      let(:attempts) { ['1', '90', '3', '33', '34'] }
      it 'exists on the 5th guess and print you won' do
        lines = play_with_attempts(attempts)

        expect(lines).to eq [
                              'Pick a number 1-100 (5 guesses left):',
                              '1 is too low!',
                              'Pick a number 1-100 (4 guesses left):',
                              '90 is too high!',
                              'Pick a number 1-100 (3 guesses left):',
                              '3 is too low!',
                              'Pick a number 1-100 (2 guesses left):',
                              '33 is too low!',
                              'Pick a number 1-100 (1 guesses left):',
                              'You won!'
                            ]
      end
    end
  end

end