require_relative '../../classes/authors/author'
require_relative 'author_store'

module AuthorManager
  include AuthorsStore

  def initialize_author_manager
    @authors = []
  end

  def add_author(first_name, last_name)
    initialize_author_manager unless @authors
    author = Author.new(first_name, last_name)
    @authors << author
    save_authors
    author
  end

  def list_authors
    authors = retrieve_authors
    @authors = authors.map { |author| Author.from_hash(author) }
  end

  def display_all_authors
    initialize_author_manager unless @authors
    @authors.each_with_index do |author, _index|
      puts "#{author.id}) Firstname: #{author.first_name}, Lastname: #{author.last_name}"
    end
  end
end
