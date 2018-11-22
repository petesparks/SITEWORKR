class Match < ApplicationRecord
  belongs_to :user
  belongs_to :job

  has_many :reviews, dependent: :destroy

  # belongs_to :sender, :foreign_key => :sender_id, class_name: "User"
  # belongs_to :recipient, :foreign_key => :recipient_id, class_name: "User"
  # belongs_to :match


  has_many :messages, dependent: :destroy


end
