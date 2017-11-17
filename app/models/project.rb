class Project < ApplicationRecord

  validates :name, presence: true, uniqueness: true, length: { in: 3..75 }
  validates :description, presence: true, length: { maximum: 1000 }
end
