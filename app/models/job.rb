class Job < ApplicationRecord
  belongs_to :user
  has_many :matches, dependent: :destroy
  validates :location, presence: true
  validates :skill, presence: true

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?





  def self.index_for_company(person)
    jobs_company = []
    Job.all.each { |job| jobs_company << job if (job.user_id == person.id) && job.title != 'Query' }
    jobs_company
  end

  def self.index_for_contractor(person)
    jobs_contractor = []
    Job.all.each do |job|
      if job.title != "Query"
        job.matches.each { |match| jobs_contractor << job if match.user_id == person.id}
      end
    end
    jobs_contractor
  end
end


  # validate :available_at_is_in_the_future

  # def available_at_is_in_the_future
  #   if available_at.present? && available_at <= Date.start_date
  #     errors.add(:available_at, "must be in the future")
  #   end
  # end
