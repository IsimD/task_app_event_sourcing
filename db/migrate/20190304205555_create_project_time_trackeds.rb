class CreateProjectTimeTrackeds < ActiveRecord::Migration[5.2]
  def change
    create_table :project_time_trackeds, id: false do |t|
      t.string :id,           primary_key: true
      t.string :project_id,   null: false
      t.float  :time_tracked, null: false

      t.timestamps
    end
  end
end
