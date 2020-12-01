class Removetaskcolumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :tasks, :started_at, :datetime
    remove_column :tasks, :started, :boolean
  end
end
