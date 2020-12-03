require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should create new task" do
    category = Category.first
    post "/categories/#{category.id}/tasks", params: { task: { name: "create name", details: "create details", completed: false, category_id: category.id } }
    assert_redirected_to category_tasks_path
    assert Task.find_by(name: "create name")
  end
  test "should get edit" do
    task = Task.first
    get edit_category_task_path(task.category_id, task.id)
    assert_response :success
  end
  test "should update task" do
    task = Task.first
    patch "/categories/#{task.category_id}/tasks/#{task.id}", params: { task: { name: "update name updated", details: "update details updated", completed: false, category_id: task.id } }
    assert_redirected_to category_tasks_path

    task = Task.find(task.id)
    assert_equal(task.name, "update name updated")
    assert_equal(task.details, "update details updated")
  end
  test "should delete task" do
    task = Task.first
    delete "/categories/#{task.category_id}/tasks/#{task.id}"
    assert_redirected_to category_tasks_path
    assert_not Task.find_by(id: task.id)
  end
end
