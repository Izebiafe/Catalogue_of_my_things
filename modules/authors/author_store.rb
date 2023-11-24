require 'fileutils'
require 'json'

module AuthorsStore
  def save_authors
    file_path = 'data/authors.json'
    FileUtils.mkdir_p(File.dirname(file_path)) unless File.directory?(File.dirname(file_path))
    File.write(file_path, '[]') unless File.exist?(file_path)
    json_data = @authors.map(&:to_hash)
    pretty_json = JSON.pretty_generate(json_data)
    File.write(file_path, pretty_json)
  end

  def retrieve_authors
    return [] unless File.exist?('data/authors.json')

    data = File.read('data/authors.json')
    JSON.parse(data)
  end
end
