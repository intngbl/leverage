require 'spec_helper'

describe ConfirmationsController do

  describe "Account confirmation" do
    before(:each) do
      @user = FactoryGirl.create(:unconfirmed_user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      create_roles
    end

    describe "When user attempts to get an admin role" do
      before(:each) do
        put 'confirm', user: { role_ids: 1, confirmation_token: @user.confirmation_token }
      end
      it { response.should_not be_success }
      it { flash[:error].should == I18n.t('rolify.new.error') }
      it { @user.confirmed_at.should be_nil }
    end

    describe "When user confirmation fails" do
      it "should display errors" do
        put 'confirm', user: { role_ids: 2 }
        flash[:error].should_not be_nil
      end
    end
  end

end
