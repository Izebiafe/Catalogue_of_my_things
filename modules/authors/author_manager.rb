require_relative '../../classes/authors/author'
require_relative './author_store'

module AuthorManager
  include AuthorsStore
    
  def add_author(first_name, last_name)
    author = Author.new(first_name, last_name);
    @authors << author
    save_authors
    author
  end

  def list_authors
    authors = get_authors
    @authors = authors.map {|author| Author.new(author.first_name, author.last_name, author.id)}
  end

  def display_all_authors
    @authors.each_with_index do |author, index|
      puts "#{author.id}) Firstname: #{author.first_name}, Lastname: #{author.last_name}"
    end
  end
end