require_relative '../../classes/games/game'
require_relative '../../classes/authors/author'
require_relative '../authors/author_store'
require_relative './game_store'

module GameManager
  include GamesStore
  include AuthorsStore

  def add_game_with_existing_author(publish_date, last_played_at, multiplayer, author_id)
    game = Game.new(publish_date, id = nil, last_played_at, false, multiplayer)
    author = @authors.find {|author| author.id == author_id}
    game.add_author(author)
    @games << game
    save_games
  end

  def add_game_with_new_author(publish_date, last_played_at, multiplayer, first_name, last_name)
    game = Game.new(publish_date, id = nil, last_played_at, false, multiplayer)
    author = add_author(first_name, last_name)
    game.add_author(author)
    @games << game
    save_games
  end

  def list_games
    games = get_games
    @games = games.map do |game|
      game_obj = Game.new(game.publish_date, game.id, game.last_played_at, game.archived, game.multiplayer)
      game_obj.add_author(Author.new(game.author.first_name, game.author.last_name))
      game_obj
    end
  end

  def display_all_games
    @games.each_with_index do |game|
      author_name = "#{game.author.first_name} #{game.author.last_name}" 
      puts "#{game.id}) Published on: #{game.publish_date}, Last played on: #{game.last_played_at} Archived: #{game.archived ? 'Yes' : 'No'} Mutliplayer: #{game.multiplayer ? 'Yes' : 'No'} Author: #{author_name}"
    end
  end

  def add_game
    puts 'Add New Game wizard, type # anytime to exit.'
    publish_date = input_date('publish date')
    return if(publish_date == "#")
    last_played_at = input_date('last play date')
    return if(last_played_at == "#")
    multiplayer = input_multiplayer
    return if(multiplayer == "#")
    while multiplayer != 'y' && multiplayer != 'n'
        puts('Please choose y or n')
        multiplayer = input_multiplayer
        return if(multiplayer == "#")
    end
    author = input_author
    return if(author == "#")
    if author.is_a?(Integer)
      add_game_with_existing_author(publish_date, last_played_at, multiplayer, author)
    else
      add_game_with_new_author(publish_date, last_played_at, multiplayer, author.split(' ')[0], author.split(' ')[1])
    end
    puts('Game successfully added!')
  end

  def input_date(type)
    if (type == 'last play date')
      puts 'When was the last time you playe this game, give the date in following format: dd/mm/yyyy'
      gets.chomp
    else
      puts 'Please Enter publish date in following format: dd/mm/yyyy'
      gets.chomp
    end
  end

  def input_multiplayer
    puts 'Do you often play this game with others ?(answer y for yes or n for no)'
    gets.chomp
  end

  def input_author
    puts 'Who is the author ?(answer with the author id or new if it a new author)'
    res = input_author_from_list
    return res if res == '#'
    return input_new_author if res == 'new'
    while @authors.find {|author| author.id == res.to_i}
        puts('Please choose an existing id of type new for a new author')
        res = input_author_from_list
        return res if res == '#'
        return input_new_author if res == 'new'
    end
    res.to_i
  end

  def input_author_from_list
    display_all_authors
    res = gets.chomp
  end

  def input_new_author
    puts 'Please enter the author firstname'
    firstname = gets.chomp
    return firstname if firstname == '#'
    puts 'Please enter the author lastnale'
    lastname = gets.chomp
    return lastname if lastname == '#'
    "#{firstname} #{lastname}"
  end
end