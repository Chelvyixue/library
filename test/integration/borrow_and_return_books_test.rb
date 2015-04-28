require 'test_helper'

class BorrowAndReturnBooksTest < ActionDispatch::IntegrationTest

  def setup
    @admin = admins(:admin)
    @baoyu = cards(:baoyu)
    @daiyu = cards(:daiyu)
    @novel = books(:novel)
    @poem = books(:poem)
    log_in_as(@admin)
  end

  test "no book should be borrowed" do
    assert_equal @baoyu.borrows.size, 0
    assert_equal @daiyu.borrows.size, 0
  end

  test "borrow one book" do
    post card_id_path, id: @baoyu.id
    assert_template 'cards/show'
    debugger
    assert_difference "@baoyu.borrows.size", 1 do
      patch borrow_book_id_path, isbn: @novel.isbn, id: @baoyu.id
    end
  end

  test "cannot borrow books with 0 storage" do
    patch borrow_book_id_path, isbn: @novel.isbn, id: @baoyu.id
    assert_no_difference "@daiyu.borrows.size" do
      patch borrow_book_id_path, isbn: @novel.isbn, id: @daiyu.id
    end
  end

  test "return one book" do
    patch borrow_book_id_path, isbn: @novel.isbn, id: @baoyu.id
    assert_difference "@baoyu.borrows.size", -1 do
      patch return_book_id_path, isbn: @novel.isbn, id: @baoyu.id
    end
  end

  test "one cannot return books that he didn't borrow" do
    assert_no_difference "@baoyu.borrows.size" do
      patch return_book_id_path, isbn: @novel.isbn, id: @baoyu.id
    end
  end
end
