require 'rspec'
require 'date'
require_relative '../../classes/books/book'
describe Book do
  it 'has accessors for id, title, publish_date, publisher, and cover_state' do
    book = Book.new('good', 'Test Publisher', '13/12/2022', 1)
    expect(book.id).to eq(1)
    expect(book.publish_date).to eq('13/12/2022')
    expect(book.publisher).to eq('Test Publisher')
    expect(book.cover_state).to eq('good')
  end

  it 'can be archived if cover state is bad' do
    book = Book.new('bad', 'Test Publisher', '14/05/2003', 1)
    expect(book.can_be_archived?).to eq(true)
  end
end
