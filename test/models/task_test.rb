require "test_helper"

class TaskTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers
  # test "the truth" do
  #   assert true
  # end
  def setup
    @category = Category.first
    @user = User.first
    sign_in @user
  end

  test "should save Task" do
    task = Task.new(name: "some name", category_id: @category.id, user_id: @user.id )
    assert task.save
  end

  test "should not save Task without name" do
    task = Task.new(category_id: @category.id)
    assert_not task.save
  end
end
