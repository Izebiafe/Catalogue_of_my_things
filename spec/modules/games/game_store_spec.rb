require 'rspec'
require 'fileutils'
require_relative '../../../classes/games/game'
require_relative '../../../classes/authors/author'
require_relative '../../../modules/games/game_store'
require_relative '../../../modules/games/game_manager'

class GameStoreClass
  include GamesStore
  include GameManager
  attr_accessor :games

  def initialize(games)
    @games = games
  end
end

RSpec.describe GamesStore do
  let(:game_store_instance) { GameStoreClass.new([]) }

  before(:each) do
    FileUtils.mkdir_p 'data'
  end

  after(:each) do
    FileUtils.rm_rf 'data'
  end

  describe '#save_games' do
    it 'saves games to a JSON file' do
      game = Game.new('01/01/2022', 1, '02/01/2022', archived: false, multiplayer: true)
      game.add_author(Author.new('John', 'Doe', 1))
      game_store_instance.games << game
      game_store_instance.save_games

      file_path = 'data/games.json'
      expect(File).to exist(file_path)

      content = File.read(file_path)
      json_data = JSON.parse(content)

      expect(json_data).to be_an(Array)
      expect(json_data).to_not be_empty
      expect(json_data.first['id']).to eq(game.id)
      expect(json_data.first['publish_date']).to eq(game.publish_date)
    end
  end

  describe '#retrieve_games' do
    it 'reads games from a JSON file' do
      data = [{ 'id' => 1, 'publish_date' => '01/01/2022', 'last_played_at' => '02/01/2022', 'archived' => false,
                'multiplayer' => true, 'author' => { 'first_name' => 'Jane', 'last_name' => 'Smith' } }]
      File.write('data/games.json', JSON.generate(data))

      game_store_instance.list_games

      expect(game_store_instance.games).to_not be_empty
      expect(game_store_instance.games.first).to be_an_instance_of(Game)
      expect(game_store_instance.games.first.id).to eq(1)
      expect(game_store_instance.games.first.publish_date).to eq('01/01/2022')
    end
  end
end
