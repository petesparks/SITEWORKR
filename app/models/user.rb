class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :jobs, through: :matches
  has_many :matches


  mount_uploader :photo, PhotoUploader
  mount_uploader :banner, PhotoUploader


  validates :name, presence: true, uniqueness: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def self.latest_not_companies
    last_three = []
    last_three << User.where(company: 'false')
    return last_three[0].sample(3)
  end
end
