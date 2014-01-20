### Given

Given(/^Thus able to (\w+) a tweet/) do |action|
  current_user_attributes = @user_attributes[@current_user_name.to_sym]
  u = User.where(name: current_user_attributes[:name]).first
  Ability.new(u).can?(action.to_sym, Tweet.new).should be_true
end

Given(/^Campaign "(.+)" has (\d+) tweet/) do |title, count|
  campaign = Campaign.where(title: title).first
  count.to_i.times { FactoryGirl.create(:tweet, campaign: campaign) }
end

### When

When(/^I go to the list of "(.*?)" tweets$/) do |title|
  @campaign = Campaign.where(title: title).first
  visit campaign_tweets_path(@campaign)
end

When(/^I try to create a tweet for "(.*?)"$/) do |title|
  campaign = Campaign.where(title: title).first
  crafted_parameters = { body: "Hacked 4 the LULZ" }
  post "/campaigns/#{campaign.id}/tweets", crafted_parameters
end

### Then

Then(/^"(.*?)" should have (\d+) tweet/) do |title, count|
  campaign = Campaign.where(title: title).first
  campaign.tweets.count.should eq(count.to_i)
end

Then(/^Tweet "(.*?)" should be assigned to "(.*?)"$/) do |tweet_body, user_name|
  Tweet.where(body: tweet_body).first.tweeter.should eq(User.where(name: user_name).first)
end

