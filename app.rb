class App
  attr_accessor :books, :label

  def initialize
    @books = []
    @label = []
    @genres = []
    @music_albums = []
    @games = []
    @authors = []
  end

  def run_till6(option)
    case option
    when 1
      display_books
    when 2
      display_all_music_albums
    when 3
      display_all_games
    when 4
      display_all_genres
    when 5
      display_labels
    else
      puts 'Thank you for using this app!'
      save_and_exit
    end
  end

  def run_more_than6(option)
    case option
    when 6
      display_all_authors
    when 7
      add_book
    when 8
      add_music
    when 9
      add_game
    else
      puts 'Thank you for using this app!'
      save_and_exit
    end
  end

  def save_and_exit
    exit
  end
end
