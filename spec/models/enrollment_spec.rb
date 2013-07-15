require 'spec_helper'

describe Enrollment do

  let(:user) { FactoryGirl.create(:user) }
  let(:campaign) { FactoryGirl.create(:campaign) }
  let(:enrollment) { user.enrollments.create(campaign_id: campaign.id) }

  subject { enrollment }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Enrollment.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "association methods" do
    it { should respond_to(:user) }
    it { should respond_to(:campaign) }
    its(:user) { should == user }
    its(:campaign) { should == campaign }
  end

  describe "when campaign id is not present" do
    before { enrollment.campaign_id = nil }
    it { should_not be_valid }
  end

  describe "when enrolled user id is not present" do
    before { enrollment.user_id = nil }
    it { should_not be_valid }
  end

  describe "it should not be authorized by default" do
    it { enrollment.authorized?.should be_false }
  end

  context "when authorized" do
    before { enrollment.authorize! }
    it { enrollment.authorized?.should be_true }
    it { user.authorized_for?(campaign).should be_true }
  end
end
