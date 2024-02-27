class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user

  enum status: { not_started: 0, in_progress: 1, completed: 2 }
end
