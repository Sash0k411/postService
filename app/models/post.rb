class Post < ApplicationRecord
  belongs_to :user

  # Enum for status values
  enum status: { draft: 0, pending_review: 1, approved: 2, rejected: 3 }

  # Validations
  validates :content, presence: true
  validates :region_id, presence: true

  has_many_attached :images
  has_many_attached :files

  scope :by_region, ->(region_id) { where(region_id: region_id) if region_id.present? }
  scope :by_author, ->(author_id) { where(user_id: author_id) if author_id.present? }
  scope :by_date_range, ->(start_date, end_date) {
    where(created_at: start_date.beginning_of_day..end_date.end_of_day) if start_date.present? && end_date.present?
  }
end
