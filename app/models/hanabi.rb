class Hanabi < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :body, length: { maximum: 140 }
end
