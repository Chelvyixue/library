require 'test_helper'

class BooksControllerTest < ActionController::TestCase

  def setup
    Book.create(isbn: 10001, title: "10001", category: "10001", publisher: "10001",
                author: "10001", year: 1999, price: 10.10, total_storage: 2, storage: 2)
    Book.create(isbn: 10002, title: "10001", category: "10001", publisher: "10001",
                author: "10001", year: 1999, price: 10.10, total_storage: 2, storage: 2)
  end
end
