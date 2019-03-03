class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks, id: false do |t|
      t.string :id,           primary_key: true
      t.string :name,         null: false
      t.string :description
      t.string :project_id,   null: false

      t.timestamps
    end
  end
end
