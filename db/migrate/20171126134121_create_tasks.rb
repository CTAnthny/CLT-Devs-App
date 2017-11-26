class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.belongs_to :project, index: { unique: true }, foreign_key: true
      t.string :name, null: false
      t.text :description, null: false
      t.text :keywords
      t.text :needs

      t.timestamps
    end
  end
end
