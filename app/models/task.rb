class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :status, inclusion: { in: %w[pending in_progress completed] }
  validates :due_date, presence: true
end
