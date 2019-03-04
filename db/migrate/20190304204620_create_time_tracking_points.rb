class CreateTimeTrackingPoints < ActiveRecord::Migration[5.2]
  def change
    create_table :time_tracking_points, id: false do |t|
      t.string :id,             primary_key: true
      t.string :task_id,        null: false
      t.string :user_id,        null: false
      t.datetime :start_time,   null: false
      t.datetime :stop_time

      t.timestamps
    end
  end
end
