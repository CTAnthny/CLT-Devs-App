class AddUniqueIdxToTasks < ActiveRecord::Migration[5.1]
  def change
    remove_index :tasks, :project_id
    add_index :tasks, [:name, :project_id], unique: true
  end
end
