require 'json'

module AuthorsStore
  def save_authors
    file_path = "data/authors.json"
    File.write(file_path, '[]') unless File.exist?(file_path)
    json_data = @games.map(&:to_hash)
    File.write(file_path, json_data)
  end

  def get_authors
    data = File.read("data/authors.json")
    JSON.parse(data)
  end
end