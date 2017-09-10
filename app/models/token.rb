class Token < ApplicationRecord
  belongs_to :user
  validates :token, presence: true
  validates :token, uniqueness: true

  after_initialize :set_token

  private

  def set_token
    loop do
      unique_token = !self.class.where.not(id: id).
        exists?(token: token)
      break if token.present? && unique_token
      self.token = SecureRandom.hex
    end
  end
end
