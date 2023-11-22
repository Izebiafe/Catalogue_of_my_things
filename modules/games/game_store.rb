require 'json'

module GamesStore
  def save_games
    file_path = 'data/games.json'
    FileUtils.mkdir_p(File.dirname(file_path)) unless File.directory?(File.dirname(file_path))
    File.write(file_path, '[]') unless File.exist?(file_path)
    json_data = @games.map(&:to_hash)
    pretty_json = JSON.pretty_generate(json_data)
    File.write(file_path, pretty_json)
  end

  def retrieve_games
    return [] unless File.exist?('data/games.json')

    data = File.read('data/games.json')
    JSON.parse(data)
  end
end
