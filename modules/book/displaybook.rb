module DisplayBook
  def display_books
    if @books.empty?
      puts 'No books availabel.'
    else
      @books.each_with_index do |book, index|
        label_title = book.label ? book.label.title : 'N/A'
        puts "#{index}) Publisher: #{book.publisher}, Publish Date: #{book.publish_date}, Label: #{label_title}"
      end
    end

    puts 'Press Enter to continue!'
    gets.chomp
  end

  def display_labels
    if @label.empty?
      puts 'No labels availabel.'
    else
      @label.each_with_index do |label, index|
        puts "#{index}) Title: #{label.title}, Color: #{label.color}"
      end
    end

    puts 'Press Enter to continue!'
    gets.chomp
  end
end
