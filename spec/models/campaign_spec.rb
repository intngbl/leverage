require 'spec_helper'

describe Campaign do

  let(:user) { FactoryGirl.create(:user) }
  before { @campaign = user.campaigns.build(title: "Lorem", brief: "Lorem ipsum dolor") }

  subject { @campaign }

  it { should respond_to(:title) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:enrollments) }
  it { should respond_to(:joined_users) }
  it { should respond_to(:tweets) }
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Campaign.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @campaign.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @campaign.title = " " }
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { @campaign.title = "foo" * 47 }
    it { should_not be_valid }
  end

  describe "with blank brief" do
    before { @campaign.brief = " " }
    it { should_not be_valid }
  end

  describe "with brief that is too long" do
    before { @campaign.brief = "foo" * 47 }
    it { should_not be_valid }
  end

  describe "users who joined the campaign" do
    before do
      @campaign.save
      @other_user = FactoryGirl.create(:user)
      @other_user.join!(@campaign)
    end
    its(:joined_users) { should include(@other_user) }
  end

end
