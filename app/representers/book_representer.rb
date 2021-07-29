class BookRepresenter
  def initialize(book)
    @book = book
  end

  def as_json
    {
      id: book.id,
      title: book.title,
      author_name: author_name(book),
      author_age: book.author.age
    }
  end

  private

  def author_name(book)
    "#{book.author.first_name} #{book.author.last_name}"
  end

  attr_reader :book
end
