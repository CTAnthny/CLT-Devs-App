class RemoveUniqIdxFromTasks < ActiveRecord::Migration[5.1]
  def change
    remove_index :tasks, :project_id
    add_index :tasks, :project_id
  end
end
