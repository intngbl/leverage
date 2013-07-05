require 'spec_helper'

describe EnrollmentsController do
  before(:all) do
    create_roles
  end

  before(:each) do
    @some_agency = FactoryGirl.create(:agency)
    @user = FactoryGirl.create(:user)
    sign_in @user
    @campaign = FactoryGirl.create(:campaign, user: @some_agency)
    @user.roles = []
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "'create'" do
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

  describe "'destroy'" do
    describe "when users tries to unsubscribe another user from a campaign" do
      before do
        @user.add_role(:tweeter)
        @user.join!(@campaign)
        @enrollment = @user.enrollments.last
        @other_user = FactoryGirl.create(:user)
        @campaign_owner = @campaign.user
      end
      it "should failed if user is not the campaign owner" do
        sign_in @other_user
        expect {
          delete :destroy, user_id: @campaign_owner, campaign_id: @campaign, id: @enrollment
        }.to_not change{@user.joined_campaigns.count}.by(-1)
      end
      it "should succeed if user is an agency and the owner of the campaign" do
        sign_in @some_agency
        expect {
          delete :destroy, user_id: @campaign_owner, campaign_id: @campaign, id: @enrollment
        }.to change{@user.joined_campaigns.count}.by(-1)
        expect{Enrollment.find(@enrollment)}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

end
