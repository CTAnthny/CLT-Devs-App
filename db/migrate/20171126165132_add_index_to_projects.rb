class AddIndexToProjects < ActiveRecord::Migration[5.1]
  def change
    change_table :projects do |t|
      t.index :creator_id
    end
  end
end
