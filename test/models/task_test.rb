require "test_helper"

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @category = Category.first
  end

  test "should save Task" do
    task = Task.new(name: "some name", category_id: @category.id)
    assert task.save
  end

  test "should not save Task without name" do
    task = Task.new(category_id: @category.id)
    assert_not task.save
  end
end
