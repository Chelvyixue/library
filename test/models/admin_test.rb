require 'test_helper'

class AdminTest < ActiveSupport::TestCase

  def setup
    @admin = Admin.new(name: "admin1", email: "admin@foo.bar",
                       password: "password", password_confirmation: "password")
  end

  test "admin should be valid" do
    assert @admin.valid?
  end

  test "should have a correct email format" do
    @admin.email = "a@aa"
    assert_not @admin.valid?
  end

  test "name should not be empty" do
    @admin.name = "   "
    assert_not @admin.valid?
  end

  test "password should be at least 6 characters" do
    @admin.password = "aaa"
    @admin.password_confirmation = "aaa"
    assert_not @admin.valid?
  end
end
