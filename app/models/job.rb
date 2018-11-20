class Job < ApplicationRecord
  belongs_to :user
  has_many :matches
  validates :location, presence: true
  validates :skill, presence: true

end


  # validate :available_at_is_in_the_future

  # def available_at_is_in_the_future
  #   if available_at.present? && available_at <= Date.start_date
  #     errors.add(:available_at, "must be in the future")
  #   end
  # end
