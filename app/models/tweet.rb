class Tweet < ActiveRecord::Base
  attr_accessible :body, :tweeted_at, :tweeter_id, :authorized
  belongs_to :campaign
  belongs_to :tweeter, class_name: "User"

  validates :body, presence: true, length: { maximum: 140 }
  validates :campaign_id, presence: true

  def sponsor
    self.campaign.user
  end

  def schedule_tweet
    TweetWorker.perform_at(tweeted_at, id)
  end

  def on_time?
    Time.now < tweeted_at
  end
end

