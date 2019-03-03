class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects, id: false do |t|
      t.string :id,           primary_key: true
      t.string :name,         null: false
      t.string :description

      t.timestamps
    end
  end
end
