class Candidate < ActiveRecord::Base
  extend FriendlyId
  acts_as_api
  belongs_to :constituency
  belongs_to :party

  friendly_id :slug_candidates, use: :slugged

  phony_normalize :phone_1, default_country_code: 'IE'
  phony_normalize :phone_2, default_country_code: 'IE'
  
  api_accessible :default do |template|
    template.add :first_name
    template.add :last_name
    template.add :aka
    template.add :date_of_birth
    template.add :gender
    template.add :current_td
    template.add :photo_url
    template.add :party_profile_url
    template.add :website_url
    template.add :twitter_url
    template.add :facebook_url
    template.add :instagram_url
    template.add :linkedin_url
    template.add :youtube_url
    template.add :source_url
    template.add :voting_record_url
    template.add :claimed_expenses
    template.add :party_name, as: :party
    template.add :constituency_name, as: :constituency
    template.add :path
  end

  def party_name
    party.name
  end

  def constituency_name
    constituency.name
  end

  def slug_candidates
    [
      [:first_name, :last_name],
      [:first_name, :last_name, :id]
    ]
  end

  def label
    [first_name, last_name].join(' ')
  end

  def path
    "/candidates/#{slug}"
  end
end
