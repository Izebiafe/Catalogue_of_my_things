require 'json'
require_relative '../../classes/books/book'
require_relative '../../classes/labels/label'

module PreserveData
  BOOK_FILE_NAME = 'data/book.json'.freeze
  LABEL_FILE_NAME = 'data/label.json'.freeze

  def save_to_file(file_name, data)
    FileUtils.mkdir_p(File.dirname(file_name)) unless File.directory?(File.dirname(file_name))
    File.write(file_name, '[]') unless File.exist?(file_name)
    File.write(file_name, JSON.pretty_generate(data))
  end

  def save_book
    books_hash = @books.map do |book|
      {
        cover_state: book.cover_state,
        publisher: book.publisher,
        publish_date: book.publish_date,
        id: book.id,
        label: book.label.title
      }
    end
    save_to_file(BOOK_FILE_NAME, books_hash)
  end

  def save_label
    label_hash = @label.map do |label|
      {
        id: label.id,
        color: label.color,
        title: label.title
      }
    end
    save_to_file(LABEL_FILE_NAME, label_hash)
  end

  def load_books
    books_hash = []
    return books_hash unless File.exist?(BOOK_FILE_NAME)

    books_hash = load_file(BOOK_FILE_NAME)

    books_hash.each do |book|
      book_obj = Book.new(book['cover_state'], book['publisher'], book['publish_date'], book['id'])
      label_obj = @label.find { |label| label.title == book['label'] }
      book_obj.add_label(label_obj)
      @books << book_obj
    end
  end

  def load_labels
    labels_hash = []
    return labels_hash unless File.exist?(LABEL_FILE_NAME)

    labels_hash = load_file(LABEL_FILE_NAME)

    labels_hash.each do |label|
      label_obj = Label.new(label['id'], label['title'], label['color'])
      @label << label_obj
    end
  end
end
