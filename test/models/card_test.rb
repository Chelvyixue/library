# coding: utf-8
require 'test_helper'

class CardTest < ActiveSupport::TestCase

  def setup
    @card = Card.new(name: "xiaoming", dept: "test", card_type: "学生")
  end

  test "card is valid" do
    assert @card.valid?
  end

  test "type should be in student and teacher" do
    @card.card_type = "student"
    assert_not @card.valid?
  end

end
