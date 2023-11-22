require 'rspec'
require 'fileutils'
require_relative '../../../classes/games/game'
require_relative '../../../classes/authors/author'
require_relative '../../../modules/authors/author_store'
require_relative '../../../modules/games/game_manager'
require_relative '../../../modules/authors/author_manager'

class GameManagerClass
  include GameManager
  include AuthorManager
  include AuthorsStore
  include GamesStore
  attr_accessor :games, :authors

  def initialize(games, authors)
    @games = games
    @authors = authors
  end
end

RSpec.describe GameManager do
  let(:game_manager_instance) { GameManagerClass.new([], []) }

  before(:each) do
    FileUtils.mkdir_p 'data'
  end

  after(:each) do
    FileUtils.rm_rf 'data'
  end

  describe '#add_game_with_existing_author' do
    it 'adds a game with an existing author to the games list' do
      author = Author.new('John', 'Doe', 1)
      game_manager_instance.authors << author
      game_manager_instance.add_game_with_existing_author('01/01/2022', '02/01/2022', true, 1)

      expect(game_manager_instance.games).to_not be_empty
      expect(game_manager_instance.games.first).to be_an_instance_of(Game)
      expect(game_manager_instance.games.first.author).to eq(author)
      expect(game_manager_instance.games.first.multiplayer).to be true
    end
  end

  describe '#add_game_with_new_author' do
    it 'adds a game with a new author to the games list' do
      game_manager_instance.add_game_with_new_author('01/01/2022', '02/01/2022', false, 'Jane', 'Smith')

      expect(game_manager_instance.games).to_not be_empty
      expect(game_manager_instance.games.first).to be_an_instance_of(Game)
      expect(game_manager_instance.games.first.author).to be_an_instance_of(Author)
      expect(game_manager_instance.games.first.multiplayer).to be false
    end
  end

  describe '#valid_date?' do
    it 'returns true for a valid date format' do
      expect(game_manager_instance.valid_date?('01/01/2022')).to be true
    end

    it 'returns false for an invalid date format' do
      expect(game_manager_instance.valid_date?('2022/01/01')).to be false
    end
  end
end
