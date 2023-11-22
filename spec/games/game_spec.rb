require 'date'
require_relative '../../classes/items/item'
require_relative '../../classes/games/game'
require_relative '../../classes/authors/author'

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
      game = Game.new('01/01/222', nil, "01/01/#{two_years_ago}")
      expect(game.can_be_archived?).to be(false)
    end

    it 'returns true if the game has not been played in the last 2 years' do
      game = Game.new('01/01/222', nil, "01/01/#{three_years_ago}")
      expect(game.can_be_archived?).to be(true)
    end

    it 'returns true if the game is already archived' do
      game = Game.new('01/01/222', nil, "01/01/#{three_years_ago}", archived: true)
      expect(game.can_be_archived?).to be(true)
    end
  end

  describe '#to_hash' do
    it 'returns a hash with expected attributes' do
      author = Author.new('John', 'Doe', 1)
      instance = Game.new('2023-01-01', 1, '2023-01-02', archived: true, multiplayer: false)
      instance.add_author(author)

      expected_hash = {
        id: 1,
        publish_date: '2023-01-01',
        last_played_at: '2023-01-02',
        author: { id: 1, first_name: 'John', last_name: 'Doe' },
        archived: true,
        multiplayer: false
      }

      expect(instance.to_hash).to eq(expected_hash)
    end
  end

  describe '.from_hash' do
    it 'creates an instance from a hash' do
      hash = {
        'id' => 1,
        'publish_date' => '2023-01-01',
        'last_played_at' => '2023-01-02',
        'archived' => true,
        'multiplayer' => false
      }

      instance = Game.from_hash(hash)

      expect(instance.id).to eq(1)
      expect(instance.publish_date).to eq('2023-01-01')
      expect(instance.last_played_at).to eq('2023-01-02')
      expect(instance.archived).to eq(true)
      expect(instance.multiplayer).to eq(false)
    end
  end
end
