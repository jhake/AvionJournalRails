require "test_helper"

class TasksIntegrationTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should create new task integration" do
    get new_task_path
    assert_response :success

    category = Category.first
    post create_task_url, params: { task: { name: "create name", details: "create details", completed: false, category_id: category.id } }

    assert_redirected_to tasks_path
    follow_redirect!
    assert_response :success
    assert_select "h3", "create name (#{category.name})"
    assert_select "p", "create details"
  end

  test "should edit task integration" do
    category = Category.first

    task = Task.new(name: "new name", details: "new details", completed: false, category_id: category.id)
    task.save

    get edit_task_path(task.id)
    assert_response :success

    patch update_task_path, params: { task: { name: "edit name", details: "edit details", completed: false, category_id: category.id } }
    assert_redirected_to tasks_path
    follow_redirect!
    assert_response :success
    assert_select "h3", "edit name (#{category.name})"
    assert_select "p", "edit details"
    assert_select "h3", { count: 0, text: "First" }
    assert_select "p", { count: 0, text: "First Description" }
  end

  test "should delete task integration" do
    task = Task.find_by(name: "first task")

    get edit_task_path(task.id)
    assert_response :success

    delete delete_task_path
    assert_redirected_to tasks_path
    follow_redirect!
    assert_response :success
    assert_select "h3", { count: 0, text: "First" }
    assert_select "p", { count: 0, text: "First Description" }
  end
end
