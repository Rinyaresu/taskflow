class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :user

  enum status: { not_started: 0, in_progress: 1, completed: 2 }
end
