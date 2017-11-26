class AddCreatorIdToProjects < ActiveRecord::Migration[5.1]
  def change
    change_table :projects do |t|
      t.integer :creator_id, null: false
    end
  end
end
