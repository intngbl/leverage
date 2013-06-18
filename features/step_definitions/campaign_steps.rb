
### Given

Given(/^(\w+) (\w+) exist$/) do |role, name|
  @user_attributes ||= {}
  @user_attributes[name.to_sym] = FactoryGirl.attributes_for(:user, name: name)
  user = FactoryGirl.create(:user, @user_attributes[name.to_sym])
  user.add_role(role.downcase.to_sym)
end

Given(/^Agency (\w+) has (\d+) campaigns$/) do |name, count|
  agency = User.where(name: name).first
  count.to_i.times { FactoryGirl.create(:campaign, user: agency) }
end

Given(/^Thus able to (\w+) a Campaign/) do |action|
  current_user_attributes = @user_attributes[@current_user_name.to_sym]
  u = User.where(name: current_user_attributes[:name]).first
  Ability.new(u).can?(action.to_sym, Campaign.new).should == true
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
  visit user_campaigns_path(@agency.id)
end

When(/^I follow "(.*?)"$/) do |link_title|
  click_link(link_title)
end

When(/^I follow "(.*?)" in row (\d+)$/) do |link_title, row|
  find("tbody tr:nth-child(#{row}) > td > a:contains('#{link_title}')").click
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in(field, with: value)
end

When(/^I press "(.*?)"$/) do |button_title|
  click_button(button_title)
end

When(/^I follow link in row (\d+)$/) do |row_number|
  find("tbody tr:nth-child(#{row_number}) > td:nth-child(1) > a").click
end

When(/^I follow delete link in row (\d+)$/) do |row_number|
  find("tbody tr:nth-child(#{row_number}) > td:nth-child(6) > a").click
  page.driver.browser.switch_to.alert.accept
end

When(/^I try to create a campaign for "(.*?)"$/) do |name|
  some_user = User.where(name: name).first
  crafted_parameters = { title: "Hacked", brief: "FOR THE LULZ" }
  post "/users/#{some_user.id}/campaigns", crafted_parameters
end

When(/^I go to campaign "(.*?)"$/) do |title|
  campaign = Campaign.where(title: title).first
  visit user_campaign_path(campaign.user_id, campaign.id)
end

# Then

Then(/^I should see (\d+) campaigns$/) do |count|
  all("tbody > tr").count.should == count.to_i
end

Then(/^"(.*?)" should have (\d+) campaigns$/) do |name, count|
  user = User.where(name: name).first
  user.campaigns.count == count.to_i
end

