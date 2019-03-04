class Task < ApplicationRecord
  belongs_to :project
  has_one :task_time_tracked
  has_many :time_tracking_points
end
