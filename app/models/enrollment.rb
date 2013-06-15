class Enrollment < ActiveRecord::Base
  attr_accessible :campaign_id

  belongs_to :user
  belongs_to :campaign

  validates :user_id, presence: true
  validates :campaign_id, presence: true
end
