class User < ApplicationRecord
  enum role: { user: 0, admin: 1 }

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :full_name, presence: true
  validates :region_id, presence: true, if: -> { user? }

  has_many :posts
end
