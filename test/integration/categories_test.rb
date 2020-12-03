require "test_helper"

class CategoriesIntegrationTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should create new category integration" do
    get new_category_path
    assert_response :success

    post categories_path, params: { category: { name: "create name", description: "create description" } }
    assert_redirected_to categories_path
    follow_redirect!
    assert_response :success
    assert_select "h3", "create name"
    assert_select "p", "create description"
  end

  test "should edit category integration" do
    category = Category.find_by(name: "First")

    get edit_category_path(category.id)
    assert_response :success

    patch category_path(category.id), params: { category: { name: "edit name", description: "edit description" } }
    assert_redirected_to categories_path
    follow_redirect!
    assert_response :success
    assert_select "h3", "edit name"
    assert_select "p", "edit description"
    assert_select "h3", { count: 0, text: "First" }
    assert_select "p", { count: 0, text: "First Description" }
  end

  test "should delete category integration" do
    category = Category.find_by(name: "First")

    get edit_category_path(category.id)
    assert_response :success

    delete category_path(category.id)
    assert_redirected_to categories_path
    follow_redirect!
    assert_response :success
    assert_select "h3", { count: 0, text: "First" }
    assert_select "p", { count: 0, text: "First Description" }
  end
end
