class Hanabi < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :address, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 140 }
  attachment :image
end
