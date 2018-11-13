class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :jobs, through: :matches

  validates :name, presence: true
  validates :address, presence: true
  validates :area_of_influence, presence: true
  validates :skill, presence: true
end
