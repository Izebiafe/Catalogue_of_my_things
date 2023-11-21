require_relative '../items/item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(publish_date, id = nil, last_played_at = nil, archived: false, multiplayer: false)
    super(publish_date, id, archived: archived)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  def can_be_archived?
    current_year = Date.today.year
    last_played_year = Date.parse(@last_played_at).year
    super && current_year - last_played_year > 2
  end
end
