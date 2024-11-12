class Post < ApplicationRecord
  belongs_to :user

  # Enum for status values
  enum status: { draft: 0, pending_review: 1, approved: 2, rejected: 3 }

  # Validations
  validates :content, presence: true
  validates :region_id, presence: true
end
