class TweetWorker
  include Sidekiq::Worker

  def perform(tweet_id)
    tweet = Tweet.find(tweet_id)
    # WIP: should use, users access tokenry
    client = Twitter::Client.new(
      oauth_token: ENV["TWITTER_ACCESS_TOKEN"],
      oauth_token_secret: ENV["TWITTER_ACCESS_SECRET"]
    )
    client.update(tweet.body)
  end
end

