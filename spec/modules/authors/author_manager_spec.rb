require 'rspec'
require_relative '../../../classes/authors/author'
require_relative '../../../modules/authors/author_manager'


class AuthorManagerClass
  include AuthorManager
end

RSpec.describe AuthorManager do
  let(:author_manager_instance) { AuthorManagerClass.new }

  describe '#add_author' do
    it 'adds a new author and saves to store' do
      expect(author_manager_instance).to receive(:save_authors).once

      author = author_manager_instance.add_author('John', 'Doe')

      expect(author).to be_an_instance_of(Author)
      expect(author.first_name).to eq('John')
      expect(author.last_name).to eq('Doe')
    end
  end

  describe '#list_authors' do
    it 'loads authors from store and returns instances' do
      authors_data = [{ 'id' => 1, 'first_name' => 'Jane', 'last_name' => 'Smith' }]
      allow(author_manager_instance).to receive(:retrieve_authors).and_return(authors_data)

      authors = author_manager_instance.list_authors

      expect(authors).to be_an(Array)
      expect(authors.first).to be_an_instance_of(Author)
      expect(authors.first.first_name).to eq('Jane')
      expect(authors.first.last_name).to eq('Smith')
    end
  end

  describe '#display_all_authors' do
    it 'displays authors in the correct format' do
      authors_data = [{ 'id' => 1, 'first_name' => 'Jane', 'last_name' => 'Smith' }]
      allow(author_manager_instance).to receive(:retrieve_authors).and_return(authors_data)

      author_manager_instance.list_authors

      expect do
        author_manager_instance.display_all_authors
      end.to output("1) Firstname: Jane, Lastname: Smith\n").to_stdout
    end
  end
end
