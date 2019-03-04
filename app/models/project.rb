class Project < ApplicationRecord
  has_many :tasks
  has_one :project_time_tracked
end
