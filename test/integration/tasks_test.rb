require "test_helper"

class TasksIntegrationTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should create new task integration" do
    get new_category_task_path(Category.first.id)
    assert_response :success

    category = Category.first
    post category_tasks_path(category.id), params: { task: { name: "create name", details: "create details", completed: false, category_id: category.id } }

    assert_redirected_to category_tasks_path
    follow_redirect!
    assert_response :success
    assert_select "h3", "create name"
    assert_select "p", "create details"
  end

  test "should edit task integration" do
    category = Category.first

    task = Task.new(name: "new name", details: "new details", completed: false, category_id: category.id)
    task.save

    get edit_category_task_path(category.id, task.id)
    assert_response :success

    patch category_task_path(task.category_id, task.id), params: { task: { name: "edit name", details: "edit details", completed: false, category_id: category.id } }
    assert_redirected_to category_tasks_path
    follow_redirect!
    assert_response :success
    assert_select "h3", "edit name"
    assert_select "p", "edit details"
    assert_select "h3", { count: 0, text: "First" }
    assert_select "p", { count: 0, text: "First Description" }
  end

  test "should delete task integration" do
    task = Task.find_by(name: "first task")

    get edit_category_task_path(task.category_id, task.id)
    assert_response :success

    delete category_task_path(task.category_id, task.id)
    assert_redirected_to category_tasks_path
    follow_redirect!
    assert_response :success
    assert_select "h3", { count: 0, text: "First" }
    assert_select "p", { count: 0, text: "First Description" }
  end
end
