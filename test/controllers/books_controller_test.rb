require 'test_helper'

class BooksControllerTest < ActionController::TestCase

  def setup
    Book.create(isbn: 10001, title: "10001", category: "10001", publisher: "10001",
                author: "10001", year: 1999, price: 10.10, total_storage: 2, storage: 2)
    Book.create(isbn: 10002, title: "10001", category: "10001", publisher: "10001",
                author: "10001", year: 1999, price: 10.10, total_storage: 2, storage: 2)
  end

  test "batch import test" do
    info = "10001$2$3$4$5$6$7$10\n10001$2$3$4$5$6$7\n10002$2$3$4$5$6$7$100\n10003$title title$category$publisher$author author$1995$10.10$3\n10004$title$catogory$publisher$author%year$10.10$1"
    assert_difference "Book.count", 113 do
      post import_mul_path, book_list: info
    end
    assert_not Book.find_by(isbn: 10004)
    assert_equal Book.find_by(isbn: 10003).title "title title"
  end
end
