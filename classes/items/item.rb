require 'date'
class Item
  attr_accessor :archived, :source, :publish_date, :id, :genre, :can_be_archived, :label
  def initialize(publish_date, id = nil)
    @id = id || Random.rand(1..1000)
    @publish_date = publish_date
  end
  def add_genre(genre)
    @genre = genre
  end
  def add_author(author)
    @author = author
    author.items << self unless author.items.include?(self)
  end
  def add_label(label)
    @label = label
    @label.add_item(self)
  end
  def add_source(source)
    @source = source
    source.items << self unless source.items.include?(self)
  end
end
