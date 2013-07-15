
### Given

Given(/^Agency (\w+) has (\d+) campaigns$/) do |name, count|
  agency = User.where(name: name).first
  count.to_i.times { FactoryGirl.create(:campaign, user: agency) }
end

Given(/^Thus able to (\w+) a campaign/) do |action|
  current_user_attributes = @user_attributes[@current_user_name.to_sym]
  u = User.where(name: current_user_attributes[:name]).first
  Ability.new(u).can?(action.to_sym, Campaign.new).should be_true
end

Given(/^I should be enrolled in campaign "(.*?)"$/) do |campaign_title|
  campaign = Campaign.where(title: campaign_title).first
  assert @user.joined?(campaign), "#{@user.name} should be enrolled in #{campaign.title}"
end

Given(/^I am enrolled in campaign "(.*?)"$/) do |campaign_title|
  campaign = Campaign.where(title: campaign_title).first
  @user.enrollments.create(campaign_id: campaign.id)
end

Given(/^User "(.*?)" is enrolled in campaign "(.*?)"$/) do |user_name, campaign_title|
  user = User.where(name: user_name).first
  campaign = Campaign.where(title: campaign_title).first
  user.enrollments.create(campaign_id: campaign.id)
end

### When

When(/^I go to the list of (\w+) campaigns$/) do |name|
  @agency = User.where(name: name).first
  visit user_campaigns_path(@agency)
end

When(/^I go to the list of (\w+) joined campaigns$/) do |name|
  @user = User.where(name: name).first
  visit recruitments_user_path(@user)
end

When(/^I try to create a campaign for "(.*?)"$/) do |name|
  some_user = User.where(name: name).first
  crafted_parameters = { title: "Hacked", brief: "FOR THE LULZ" }
  post "/users/#{some_user.id}/campaigns", crafted_parameters
end

When(/^I go to campaign "(.*?)"$/) do |title|
  campaign = Campaign.where(title: title).first
  visit campaign_path(campaign)
end

When(/^I visit "(\w+)" campaigns$/) do |name|
  u = User.where(name: name).first
  visit user_campaigns_path(u)
end

# Then

Then(/^I should see (\d+) campaigns$/) do |count|
  all("tbody > tr").count.should eq(count.to_i)
end

Then(/^"(.*?)" should have (\d+) campaigns$/) do |name, count|
  user = User.where(name: name).first
  user.campaigns.count.should eq(count.to_i)
end

Then(/^"(.*?)" should have (\d+) users$/) do |title, count|
  campaign = Campaign.where(title: title).first
  campaign.joined_users.count.should eq(count.to_i)
end
