require 'spec_helper'

describe CampaignsController do

  describe "Campaign creation" do
    before(:each) do
      create_roles
      @user = FactoryGirl.create(:user)
      @user.add_role(:tweeter)
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    describe "When non-agency user attempts to create a campaign" do
      before(:each) do
        post 'create', user_id: @user.id, campaign: { title: 'L', brief: 'O' } #, user: { role_ids: 1, confirmation_token: @user.confirmation_token }
      end
      it { response.should_not be_success }
      it "should display error message" do
        pending
      end
    end
  end

end
