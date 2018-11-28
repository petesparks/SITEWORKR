class Match < ApplicationRecord
  belongs_to :user
  belongs_to :job

  has_many :reviews, dependent: :destroy
  has_many :messages, dependent: :destroy

  def self.my_matches(current_user)
    matches = []
    Match.all.each { |match| matches << match if match.job.user.id == current_user.id || match.user.id == current_user.id }
    matches
  end

  def self.new_offers(user)
    count = 0
    Match.my_matches(user).each { |match| count += 1 if match.hired && !match.accepted && !user.company }
    count
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

  def self.stars(user)
    sum = 0
    counter = 0
    Match.my_matches(user).each do |match|
      match.reviews.each do |review|
        sum += review.rating
        counter += 1
      end
    end
    (sum * 2) / counter if sum != 0
  end

  def self.ordered(user)
    matches = Match.not_queries(Match.my_matches(user))
    matches.sort_by do |match|
      if match.messages.any?
        match.messages.last.created_at
      else
        match.created_at
      end
    end
  end

  def self.ordered_queries(user)
    matches = Match.queries(Match.my_matches(user))
    matches.sort_by do |match|
      if match.messages.any?
        match.messages.last.created_at
      else
        match.created_at
      end
    end
  end
end
