class AddCreatorIdToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :creator_id, :integer, null: false
  end
end
