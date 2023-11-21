require 'date'
require_relative '../../classes/items/item'
require_relative '../../classes/games/game'

RSpec.describe Game do
  let(:current_year) { Date.today.year }
  let(:two_years_ago) { current_year - 2 }
  let(:three_years_ago) { current_year - 3 }

  describe '#initialize' do
    it 'creates a Game instance with default values' do
      game = Game.new('01/01/222')
      expect(game.archived).to be(false)
      expect(game.multiplayer).to be(false)
      expect(game.last_played_at).to be_nil
    end

    it 'creates a Game instance with specified values' do
      game = Game.new('01/01/222', 1, '15/03/2022', archived: true, multiplayer: true)
      expect(game.id).to eq(1)
      expect(game.archived).to be(true)
      expect(game.multiplayer).to be(true)
      expect(game.last_played_at).to eq('15/03/2022')
    end
  end

  describe '#can_be_archived?' do
    it 'returns false if the game has been played in the last 2 years' do
      game = Game.new('01/01/222', nil, '01/01/'+two_years_ago.to_s)
      expect(game.can_be_archived?).to be(false)
    end

    it 'returns true if the game has not been played in the last 2 years' do
      game = Game.new('01/01/222', nil, '01/01/'+three_years_ago.to_s)
      expect(game.can_be_archived?).to be(true)
    end

    it 'returns true if the game is already archived' do
      game = Game.new('01/01/222', nil, '01/01/'+three_years_ago.to_s, archived: true)
      expect(game.can_be_archived?).to be(true)
    end
  end
end
