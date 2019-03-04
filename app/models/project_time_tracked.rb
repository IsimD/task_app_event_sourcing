class ProjectTimeTracked < ApplicationRecord
  belongs_to :project
  has_one :project_time_tracked
end
