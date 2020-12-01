class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :details

      t.datetime :deadline
      t.datetime :started_at
      t.datetime :completed_at

      t.boolean :started, default: false, null: false
      t.boolean :completed, default: false, null: false

      t.integer :category_id
      t.timestamps
    end

    add_index :tasks, :category_id
  end
end
