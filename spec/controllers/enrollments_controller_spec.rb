require 'spec_helper'

describe EnrollmentsController do

  describe "Enrollment creation" do
    before do
      create_roles
      @some_agency = FactoryGirl.create(:agency)
      @user = FactoryGirl.create(:user)
      sign_in @user
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @campaign = FactoryGirl.create(:campaign, user: @some_agency)
    end

    describe "by a non-tweeter" do
      before do
        @user.add_role(:agency)
        post :create, user_id: @some_agency.id, campaign_id: @campaign.id
      end

      it "should not succeed" do
        response.should_not be_success
      end
      it "should not increment count of joined users" do
        @campaign.joined_users.count.should eq(0)
      end
    end

    describe "by a tweeter" do
      before do
        @user.roles = []
        @user.add_role(:tweeter)
        post :create, user_id: @some_agency.id, campaign_id: @campaign.id
      end

      it "should redirect to campaign page" do
        response.should redirect_to(user_campaign_path(@some_agency, @campaign))
      end
      it "should add campaign to list of user's joined campaigns" do
        @user.joined_campaigns.should include(@campaign)
      end
    end
  end

end
