class Task < ApplicationRecord
  belongs_to :project
  has_many :task_memberships
  has_many :members, through: :task_memberships

  validates :name, presence: true, uniqueness: { scope: :project_id }, length: { in: 3..75 }
  validates :description, presence: true, length: { maximum: 1000 }

  paginates_per 10
end
