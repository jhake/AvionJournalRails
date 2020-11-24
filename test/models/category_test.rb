require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should save Category" do
    category = Category.new(name: "some name")
    assert category.save
  end

  test "should not save Category without name" do
    category = Category.new
    assert_not category.save
  end

  test "Category name should be unique" do
    category_1 = Category.new(name: "some name")
    category_2 = Category.new(name: "some name")

    category_1.save
    assert_not category_2.save
  end
end
