class Project < ApplicationRecord
  has_many :project_memberships
  has_many :members, through: :project_memberships

  validates :name, presence: true, uniqueness: true, length: { in: 3..75 }
  validates :description, presence: true, length: { maximum: 1000 }
end
