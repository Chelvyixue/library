# coding: utf-8
require 'test_helper'

class BookTest < ActiveSupport::TestCase

  def setup
    @book = Book.new(isbn: 9787301089842, category: "I", title: "二十世纪西方文学理论",
                     publisher: "北京大学出版社", year: 2007, author: "特雷·伊格尔顿",
                     price: 28.00, total_storage: 1, storage: 1)
  end

  test "book is valid" do
    assert @book.valid?
  end

  test "isbn cannot be empty" do
    @book.isbn = nil
    assert_not @book.valid?
  end

  test "author cannot be empty" do
    @book.author = "  "
    assert_not @book.valid?
  end
end
