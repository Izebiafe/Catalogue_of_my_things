require_relative '../../classes/games/game'
require_relative '../../classes/authors/author'
require_relative '../authors/author_store'
require_relative 'game_store'

# rubocop:disable Metrics/ModuleLength
module GameManager
  include GamesStore
  include AuthorsStore

  def initialize_game_manager
    @games = []
    @authors = []
  end

  def add_game_with_existing_author(publish_date, last_played_at, multiplayer, author_id)
    initialize_game_manager unless @authors && @games
    game = Game.new(publish_date, nil, last_played_at, archived: false, multiplayer:)
    author = @authors.find { |a| a.id == author_id }
    game.add_author(author)
    game.move_to_archive
    @games << game
    save_games
  end

  def add_game_with_new_author(publish_date, last_played_at, multiplayer, first_name, last_name)
    initialize_game_manager unless @authors && @games
    game = Game.new(publish_date, nil, last_played_at, archived: false, multiplayer:)
    author = add_author(first_name, last_name)
    game.add_author(author)
    game.move_to_archive
    @games << game
    save_games
  end

  def list_games
    games = retrieve_games
    @games = games.map do |game|
      game_obj = Game.from_hash(game)
      game_obj.add_author(Author.new(game['author']['first_name'], game['author']['last_name']))
      game_obj
    end
  end

  def display_all_games
    initialize_game_manager unless @authors && @games
    @games.each do |game|
      author_name = "#{game.author.first_name} #{game.author.last_name}"
      puts "#{game.id}) Published on: #{game.publish_date}, " \
           "Last played on: #{game.last_played_at} " \
           "Archived: #{game.archived ? 'Yes' : 'No'} " \
           "Mutliplayer: #{game.multiplayer ? 'Yes' : 'No'} " \
           "Author: #{author_name}"
    end
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
  def add_game
    puts '* * * Add New Game wizard, type # anytime to exit. * * *'
    publish_date = input_date('publish date')
    return if publish_date == '#'

    while valid_date?(publish_date) == false
      puts 'please enter a valid date'
      publish_date = input_date('publish date')
      return if publish_date == '#'
    end

    last_played_at = input_date('last play date')
    return if last_played_at == '#'

    while valid_date?(last_played_at) == false
      puts 'please enter a valid date'
      last_played_at = input_date('last play date')
      return if last_played_at == '#'
    end

    multiplayer = input_multiplayer
    return if multiplayer == '#'

    while multiplayer != 'y' && multiplayer != 'n'
      puts('Please choose y or n')
      multiplayer = input_multiplayer
      return if multiplayer == '#'
    end

    author = input_author
    return if author == '#'

    is_multiplay = multiplayer == 'y'

    if author.is_a?(Integer)
      add_game_with_existing_author(publish_date, last_played_at, is_multiplay, author)
    else
      add_game_with_new_author(publish_date, last_played_at, is_multiplay, author.split[0], author.split[1])
    end
    puts('* * *Game successfully added! * * *')
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength

  def input_date(type)
    if type == 'last play date'
      puts 'When was the last time you played this game, give the date in following format: dd/mm/yyyy'
    else
      puts 'Please Enter publish date in following format: dd/mm/yyyy'
    end
    gets.chomp
  end

  def input_multiplayer
    puts 'Do you often play this game with others ?(answer y for yes or n for no)'
    gets.chomp
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def input_author
    initialize_game_manager unless @authors && @games
    puts 'Who is the author ?(answer with the author id or new if it a new author)'
    res = input_author_from_list
    return res if res == '#'
    return input_new_author if res == 'new'

    while @authors.find { |author| author.id == res.to_i }.nil?
      puts('Please choose an existing id or type new for a new author')
      res = input_author_from_list
      return res if res == '#'
      return input_new_author if res == 'new'
    end
    res.to_i
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def input_author_from_list
    display_all_authors
    gets.chomp
  end

  def input_new_author
    puts 'Please enter the author firstname'
    firstname = gets.chomp
    return firstname if firstname == '#'

    puts 'Please enter the author lastname'
    lastname = gets.chomp
    return lastname if lastname == '#'

    "#{firstname} #{lastname}"
  end

  def valid_date?(date)
    date_pattern = %r{^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$}
    !!(date =~ date_pattern)
  end
end
# rubocop:enable Metrics/ModuleLength
