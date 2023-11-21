# spec/author_spec.rb

require_relative '../../classes/items/item'
require_relative '../../classes/authors/author'

RSpec.describe Author do
  let(:author) { Author.new('John', 'Doe') }
  let(:item) { Item.new('Example Title') }

  describe '#initialize' do
    it 'creates an author with a random ID if ID is not provided' do
      expect(author.id).to be_a(Integer)
    end

    it 'creates an author with the specified first and last name' do
      expect(author.first_name).to eq('John')
      expect(author.last_name).to eq('Doe')
    end
  end

  describe '#add_item' do
    it 'adds an item to the author' do
      author.add_item(item)
      expect(author.items).to include(item)
      expect(item.author).to eq(author)
    end
  end
end
