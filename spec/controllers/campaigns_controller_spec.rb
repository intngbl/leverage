require 'spec_helper'

describe CampaignsController do

  describe "Campaign management" do
    before(:each) do
      create_roles
      @user = FactoryGirl.create(:user)
      @user.add_role(:tweeter)
      sign_in @user
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

    describe "When user attempts to delete another's user campaign" do
      it "should not change the number of campaigns" do
        # @other_user = FactoryGirl.create(:user)
        # @other_campaign = FactoryGirl.create(:campaign, user: @other_user)
        # params = { user_id: @other_user.id, id: @other_campaign.id }
        # delete :destroy, params
        # response.should_not be_success
        # raises ActiveRecord::RecordNotFound
        # since campaigns controller fetches campaign through current_user
        pending
      end
    end
  end

end
