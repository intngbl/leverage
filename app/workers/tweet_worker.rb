class TweetWorker
  include Sidekiq::Worker

  def perform(tweet_id)
    tweet = Tweet.find(tweet_id)
    user = tweet.tweeter
    user.twitter.update(tweet.body)
  end
end

