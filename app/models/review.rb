class Review < ApplicationRecord
  belongs_to :match
  belongs_to :user
  validates_presence_of :content, :match_id, :user_id
  validates :content, length: { maximum: 400 }
  validates :rating, inclusion: { in: [0, 1, 2, 3, 4, 5] }, presence: true, numericality: { only_integer: true }
end
