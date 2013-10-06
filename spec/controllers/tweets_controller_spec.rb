require 'spec_helper'

describe TweetsController do

  describe "Tweet management" do
    before(:each) do
      create_roles
      @user = FactoryGirl.create(:user)
      @user.add_role(:agency)
      sign_in @user
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @campaign = FactoryGirl.create(:campaign, user: @user)
    end

    it "shows campaign tweets" do
      get :index, { user_id: @user, campaign_id: @campaign }
      response.should be_success
    end

    describe "When agency attempts to delete another's campaign tweet" do
      it "should not change the number of tweets" do
        other_agency = FactoryGirl.create(:agency)
        other_campaign = FactoryGirl.create(:campaign, user: other_agency)
        other_tweet = other_campaign.tweets.create(FactoryGirl.attributes_for(:tweet))

        delete :destroy, { id: other_tweet.id }
        response.should_not be_success
      end
    end

    describe "When agency attempts to edit another's campaign tweet" do
      before do
        other_agency = FactoryGirl.create(:agency)
        other_campaign = FactoryGirl.create(:campaign, user: other_agency)
        @other_tweet = other_campaign.tweets.create(body: "Original tweet", tweeted_at: Time.now())

        @tweet_new_attributes = { body: 'Hacked by a n00b' }
        put :update, { campaign_id: other_campaign.id, id: @other_tweet.id, tweet: @tweet_new_attributes }
      end

      it { response.should_not be_success }
      it "should not have changed the tweet's body" do
        @other_tweet.body.should_not == @tweet_new_attributes[:body]
      end
    end

  end
end

