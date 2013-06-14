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
    end

    describe "When user attempts to delete another's user campaign" do
      it "should not change the number of campaigns" do
        @other_user = FactoryGirl.create(:user)
        @other_campaign = FactoryGirl.create(:campaign, user: @other_user)
        params = { user_id: @other_user.id, id: @other_campaign.id }
        delete :destroy, params
        response.should_not be_success
      end
    end

    describe "When user attempts to edit another's user campaign" do
      before do
        @other_user = FactoryGirl.create(:user)
        @other_campaign = FactoryGirl.create(:campaign, user: @other_user)
        @campaign_new_attributes = { title: 'Hacked', brief: 'by a n00b' }
        put :update, { user_id: @other_user.id, id: @other_campaign.id, campaign: @campaign_new_attributes }
      end

      it { response.should_not be_success }
      it "should not have changed the campaign's attribute" do
        @other_campaign.title.should_not == @campaign_new_attributes[:title]
      end
    end
  end

end
