require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @user = User.first
    sign_in @user
  end
  # test "the truth" do
  #   assert true
  # end
  test "should create new category" do 
    post categories_path, params: {category: {name: "create name", description: "create description"}}
    assert_redirected_to categories_path
    assert Category.find_by(name: "create name")
  end
  test "should get edit" do
    category = Category.new(name: "edit name", description: "edit description")
    category.save
    get edit_category_path(category.id)
    assert_response :success
  end
  test "should update category" do
    category = Category.new(name: "update name", description: "update description")
    category.save
    patch category_path(category.id), params: {category: {name: "update name updated", description: "update description updated"}}
    assert_redirected_to categories_path
    
    category = Category.find(category.id)
    assert_equal(category.name, "update name updated")
    assert_equal(category.description, "update description updated")
  end
  test "should delete category" do
    category = Category.new(name: "delete name", description: "delete description")
    category.save
    delete category_path(category.id)
    assert_redirected_to categories_path
    assert_not Category.find_by(id: category.id)
  end

end

