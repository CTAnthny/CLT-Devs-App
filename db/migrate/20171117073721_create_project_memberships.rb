class CreateProjectMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :project_memberships, id: false do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.belongs_to :member, index: true, foreign_key: true

      t.timestamps
    end
  end
end
