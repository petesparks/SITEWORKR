class Match < ApplicationRecord
  belongs_to :user
  belongs_to :job

  has_many :reviews, dependent: :destroy

  # belongs_to :sender, :foreign_key => :sender_id, class_name: "User"
  # belongs_to :recipient, :foreign_key => :recipient_id, class_name: "User"
  # belongs_to :match


  has_many :messages, dependent: :destroy

  def self.my_matches(current_user)
    matches = []
    Match.all.each { |match| matches << match if match.job.user.id == current_user.id || match.user.id == current_user.id }
    matches
  end

  def self.my_unread_count(current_user)
    all_messages = []

    Match.my_matches(current_user).each do |match|
      match.messages.each { |message| all_messages << message if message.user != current_user }
    end

    Match.unread_count(all_messages, current_user)

  end

  def self.unread_count(messages, current_user)
    count = 0
    messages.each { |m|  count += 1 if m.read == false && m.user != current_user }
    count
  end

  def self.queries(matches)
    queries = []
    matches.each { |match| queries << match if match.job.title == "Query"}
    queries

  end

  def self.not_queries(matches)
    jobs = []
    matches.each { |match| jobs << match if match.job.title != "Query"}
    jobs

  end

end
