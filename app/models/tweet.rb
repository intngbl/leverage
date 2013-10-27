class Tweet < ActiveRecord::Base
  attr_accessible :body, :tweeted_at, :authorized
  belongs_to :campaign
  after_commit :schedule_tweet, :on => :create

  validates :body, presence: true, length: { maximum: 140 }
  validates :campaign_id, presence: true

  def sponsor
    self.campaign.user
  end

  def schedule_tweet
    TweetWorker.perform_async(id)
  end
end

