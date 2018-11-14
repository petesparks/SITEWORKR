class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :jobs, through: :matches

  mount_uploader :photo, PhotoUploader


  validates :name, presence: true, uniqueness: true

end
