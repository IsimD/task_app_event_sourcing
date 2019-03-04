class CreateTaskTimeTrackeds < ActiveRecord::Migration[5.2]
  def change
    create_table :task_time_trackeds, id: false do |t|
      t.string :id,           primary_key: true
      t.string :task_id,      null: false
      t.float  :time_tracked, null: false

      t.timestamps
    end
  end
end
