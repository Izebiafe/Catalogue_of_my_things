require_relative 'book/addbook'
require_relative 'book/displaybook'
require_relative 'book/preservedata'
require_relative 'authors/author_store'
require_relative 'authors/author_manager'
require_relative 'games/game_store'
require_relative 'games/game_manager'
require_relative 'music/addmusic'
require_relative 'music/displaymusic'
require_relative 'music/displaygenre'
require_relative 'music/storage'

module Modules
  include AddMusic
  include DisplayMusic
  include DisplayGenres
  include Storage
  include GamesStore
  include AuthorsStore
  include AuthorManager
  include GameManager
  include AddBook
  include DisplayBook
  include PreserveData

  def save_collections
    save_music
    save_genres
  end

  def load_collections
    load_genres
    load_music_albums
    
     def save_collections
    save_book
  end

  def load_collections
    load_book
  end
end
