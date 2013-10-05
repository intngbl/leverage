class Tweet < ActiveRecord::Base
  attr_accessible :body, :tweeted_at, :authorized
  belongs_to :campaign

  validates :body, presence: true, length: { maximum: 140 }
  validates :campaign_id, presence: true
end
