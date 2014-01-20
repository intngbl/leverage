class TweetWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 1

  def perform(tweet_id)
    tweet = Tweet.find(tweet_id)
    user = tweet.tweeter
    user.twitter.update(tweet.body)
  end
end

