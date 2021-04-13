require_relative '../lib/offense_detector'

describe CheckOffenses do
  let(:check_offense) { CheckOffenses.new('tester.rb') }

  describe '#trailing_spaces' do
    it 'returns trailing whitespace at a given line' do
      check_offense.trailing_spaces
      expect(check_offense.mistakes[0]).to eql('line:1:14: Error: Trailing whitespace.')
    end
  end

  describe '#empty_line' do
    it 'returns empty line error at a given line' do
      check_offense.empty_line
      expect(check_offense.mistakes[0]).to eql('line:7 Empty line detected at block end.')
    end
  end

  describe '#indentation' do
    it 'returns indentation error' do
      check_offense.indentation
      expect(check_offense.mistakes[0]).to eql('line:8 IndentationWidth: Use 2 spaces for indentation.')
    end
  end

  describe '#end_error' do
    it 'returns missing/unexpected end' do
      check_offense.end_error
      expect(check_offense.mistakes[0]).to eql("Lint/Syntax: Missing 'end'.")
    end
  end

  describe '#tag_error' do
    it "returns missing/unexpected tags such as: '( )', '[ ]', or '{ }'" do
      check_offense.tag_error
      expect(check_offense.mistakes[0]).to eql("line:3 Lint/Syntax: Unexpected/Missing token ']' Bracket.")
    end
  end
end
