class Member < ApplicationRecord
  acts_as_taggable_on :skills, :interests

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :project_memberships
  has_many :projects, through: :project_memberships

  validates :first_name, presence: true, length: { in: 2..15 }
  validates :last_name, presence: true, length: { in: 2..25 }
  validates :email, presence: true, uniqueness: true
end
