class Article < ApplicationRecord
  scope :recent, -> { order(created_at: :desc) }

  validates :title, presence: true
  validates :content, presence: true
end
