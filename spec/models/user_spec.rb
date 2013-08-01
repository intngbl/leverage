require 'spec_helper'
require 'cancan/matchers'

describe User do

  before(:each) do
    @attr = {
      :name => "Example User",
      :email => "user@example.com",
      :password => "changeme",
      :password_confirmation => "changeme"
    }
  end

  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end

  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe "passwords" do

    before(:each) do
      @user = User.new(@attr)
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end

  end

  before { @user = FactoryGirl.create(:user) }
  subject { @user }
  let(:other_user) { FactoryGirl.create(:user) }

  describe "campaigns association" do
    it { should respond_to(:campaigns) }

    let!(:older_campaign) do
      FactoryGirl.create(:campaign, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_campaign) do
      FactoryGirl.create(:campaign, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right campaigns in the right order" do
      @user.campaigns.should == [newer_campaign, older_campaign]
    end

    it "should destroy associated campaigns" do
      campaigns = @user.campaigns.dup
      @user.destroy
      campaigns.should_not be_empty
      campaigns.each do |campaign|
        lambda do
          Campaign.find(campaign.id)
        end.should raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "joining campaigns" do
    it { should respond_to(:enrollments) }
    it { should respond_to(:joined_campaigns) }
    it { should respond_to(:joined?) }
    it { should respond_to(:join!) }
    it { should respond_to(:leave!) }

    let(:campaign) do
      FactoryGirl.create(:campaign, user: @user, created_at: 1.day.ago)
    end

    describe "join" do
      subject { other_user }
      before do
        other_user.add_role(:tweeter)
        other_user.join!(campaign)
      end
      it { should be_joined(campaign) }
      its(:joined_campaigns) { should include(campaign) }

      describe "leave" do
        before { other_user.leave!(campaign) }
        it { should_not be_joined(campaign) }
        its(:joined_campaigns) { should_not include(campaign) }
      end
    end
  end

  describe "abilities" do
    context "when is a tweeter" do
      subject { FactoryGirl.create(:tweeter) }
      context "when dealing with campaigns" do
        abilities = { catalog: true, read: true, create: false, destroy: false }
        it { should have_ability(abilities, for: Campaign) }
      end
    end
    context "when is an agency" do
      let(:agency) { FactoryGirl.create(:agency) }
      subject { agency }
      it { should have_ability(:all, for: Campaign) }
    end
  end

  context "mailbox", focus: true do
    it { should respond_to(:mailbox) }
    it { should respond_to(:reply_to_conversation) }
    it { should respond_to(:reply_to_sender) }
    it { should respond_to(:send_message) }

    context "messaging a user" do
      before { @user.send_message(other_user, "what's your opinion on the mailbox gem?", "tsup") }
      # Receipts
      it { @user.mailbox.should have(1).receipts }
      it { other_user.mailbox.should have(1).receipts }
      # Conversations
      it { @user.mailbox.sentbox.should have(1).conversations }
      it { other_user.mailbox.inbox.should have(1).conversations }

      it "should be able to reply to a conversation" do
        last_conversation = other_user.mailbox.inbox.first
        other_user.reply_to_conversation(last_conversation, "works like a charm!")
        expect(@user.mailbox.inbox).to include(other_user.mailbox.sentbox.last)
      end
    end
  end

end
