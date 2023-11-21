require_relative 'music/addmusic'
require_relative 'music/displaymusic'
require_relative 'music/displaygenre'
require_relative 'music/storage'

module Modules
  include AddMusic
  include DisplayMusic
  include DisplayGenres
  include Storage

  def save_collections
    save_music
    save_games
  end

  def load_collections
    load_genres
    load_music_albums
  end
end
