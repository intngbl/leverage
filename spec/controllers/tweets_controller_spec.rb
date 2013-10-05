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
  end

end

