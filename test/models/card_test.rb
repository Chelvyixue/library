# coding: utf-8
require 'test_helper'

class CardTest < ActiveSupport::TestCase

  def setup
    @book = Book.create(isbn: 9787301089842, category: "I", title: "二十世纪西方文学理论",
                        publisher: "北京大学出版社", year: 2007, author: "特雷·伊格尔顿",
                        price: 28.00, total_storage: 1, storage: 1)
    @card = Card.create(name: "asdfg", dept: "test", card_type: "学生")
    @admin = Admin.create(name: "admin1", email: "admin@foo.bar",
                          password: "password", password_confirmation: "password")
    @record = Record.create(card_id: @card.id, book_id: @book.id, admin_id: @admin.id)
  end

  test "card is valid" do
    assert @card.valid?
  end

  test "type should be in student and teacher" do
    @card.card_type = "invalid"
    assert_not @card.valid?
  end

  test "borrows should be not empty" do
    assert_not @card.borrows.empty?
  end

  test "borrows should be empty" do
    @record.returned_at = DateTime.new(2015,4,25)
    @record.save
    assert @card.borrows.empty?
  end
end
