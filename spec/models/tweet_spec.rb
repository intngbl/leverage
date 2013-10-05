require 'spec_helper'

describe Tweet do

  before do
    @creator = FactoryGirl.create(:user)
    @tweeter = FactoryGirl.create(:user)
    @campaign = @creator.campaigns.create(title: "Lorem", brief: "Lorem ipsum dolor")
  end

  describe "creation" do
    before { @tweet = @campaign.tweets.build(body: "Tweet this", tweeted_at: Time.now + 1.week) }

    it { @tweet.should be_valid }

    it "should be valid without a date to be tweeted" do
      a_tweet = @campaign.tweets.build(body: "Tweet this")
      a_tweet.should be_valid
    end

    it { @tweet.should respond_to(:authorized) }
    it { @tweet.should respond_to(:body) }
    it { @tweet.should respond_to(:campaign) }
    it { @tweet.should respond_to(:tweeted_at) }
    it { @tweet.authorized.should be_false }

    it "should restrict body to 140 characters" do
      bad_tweet = @campaign.tweets.build(body: 'a' * 150, tweeted_at: Time.now)
      bad_tweet.should_not be_valid
    end

    it "should be destroy if campaign is deleted" do
      some_campaign = FactoryGirl.create(:campaign)
      some_campaign.tweets.create(FactoryGirl.attributes_for(:tweet))
      some_tweet_id = some_campaign.tweets.last.id
      some_campaign.destroy

      expect { Tweet.find(some_tweet_id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

end
