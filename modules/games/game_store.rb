require 'json'

module GamesStore
  def save_games
    file_path = "data/games.json"
    File.write(file_path, '[]') unless File.exist?(file_path)
    json_data = @games.map(&:to_hash)
    File.write(file_path, json_data)
  end

  def get_games
    data = File.read("data/games.json")
    JSON.parse(data)
  end
end