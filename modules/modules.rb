require_relative 'book/addbook'
require_relative 'book/displaybook'
require_relative 'book/preservedata'

module Modules
  include AddBook
  include DisplayBook
  include PreserveData

  def save_collections
    save_book
  end

  def load_collections
    load_book
  end
end
