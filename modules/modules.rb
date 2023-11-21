require_relative 'authors/author_store'
require_relative 'authors/author_manager'
require_relative 'games/game_store'
require_relative 'games/game_manager'

module Modules
  include GamesStore
  include AuthorsStore
  include AuthorManager
  include GameManager
end