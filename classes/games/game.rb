require_relative '../items/item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(publish_date, id = nil)
    super(publish_date, id = id)
    
  end