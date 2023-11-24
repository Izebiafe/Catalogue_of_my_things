require 'rspec'
require 'fileutils'
require_relative '../../../classes/authors/author'
require_relative '../../../modules/authors/author_store'

class AuthorStoreClass
  include AuthorsStore
  attr_accessor :authors

  def initialize(authors)
    @authors = authors
  end
end

RSpec.describe AuthorsStore do
  let(:author_store_instance) { AuthorStoreClass.new([]) }

  before(:each) do
    FileUtils.mkdir_p 'data'
  end

  after(:each) do
    FileUtils.rm_rf 'data'
  end

  describe '#save_authors' do
    it 'saves authors to a JSON file' do
      author_store_instance.authors << Author.new('John', 'Doe', 1)
      author_store_instance.authors << Author.new('Jane', 'Smith', 2)

      author_store_instance.save_authors

      file_content = File.read('data/authors.json')
      expect(file_content).to include('John', 'Doe', 'Jane', 'Smith')
    end
  end

  describe '#retrieve_authors' do
    it 'loads authors from a JSON file' do
      authors_data = [{ 'id' => 1, 'first_name' => 'John', 'last_name' => 'Doe' }]
      File.write('data/authors.json', JSON.generate(authors_data))

      authors = author_store_instance.retrieve_authors

      expect(authors).to be_an(Array)
      expect(authors.first).to include('id' => 1, 'first_name' => 'John', 'last_name' => 'Doe')
    end
  end
end
