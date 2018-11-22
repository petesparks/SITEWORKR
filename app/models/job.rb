class Job < ApplicationRecord
  belongs_to :user
  has_many :matches, dependent: :destroy
  validates :location, presence: true
  validates :skill, presence: true

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

end


  # validate :available_at_is_in_the_future

  # def available_at_is_in_the_future
  #   if available_at.present? && available_at <= Date.start_date
  #     errors.add(:available_at, "must be in the future")
  #   end
  # end
