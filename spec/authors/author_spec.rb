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

  describe '#to_hash' do
    it 'returns a hash with id, first_name, and last_name' do
      instance = Author.new('John', 'Doe', 1)
      expected_hash = { id: 1, first_name: 'John', last_name: 'Doe' }
      expect(instance.to_hash).to eq(expected_hash)
    end
  end

  describe '.from_hash' do
    it 'creates an instance from a hash' do
      hash = { 'id' => 1, 'first_name' => 'Jane', 'last_name' => 'Smith' }
      instance = Author.from_hash(hash)
      expect(instance.id).to eq(1)
      expect(instance.first_name).to eq('Jane')
      expect(instance.last_name).to eq('Smith')
    end
  end
end
