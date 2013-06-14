
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

Given(/^I am not authenticated/) do
  visit '/users/sign_out'
end

Given(/^I am logged in as "(.*?)"$/) do |name|
  @current_user_name = name
  sign_in(@user_attributes[name.to_sym])
end

Given(/^Thus able to (\w+) a Campaign/) do |action|
  current_user_attributes = @user_attributes[@current_user_name.to_sym]
  u = User.where(name: current_user_attributes[:name]).first
  Ability.new(u).can?(action.to_sym, Campaign.new).should == true
end

### When

When(/^I go to the list of (\w+) campaigns$/) do |name|
  @agency = User.where(name: name).first
  visit user_campaigns_path(@agency.id)
end

When(/^I follow "(.*?)"$/) do |link_title|
  click_link(link_title)
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in(field, with: value)
end

When(/^I press "(.*?)"$/) do |button_title|
  click_button(button_title)
end

When(/^I follow link in row (\d+)$/) do |row_number|
  find("tbody tr:nth-child(#{row_number}) > td:nth-child(#{row_number}) > a").click
end

When(/^I try to create a campaign for "(.*?)"$/) do |name|
  some_user = User.where(name: name).first
  crafted_parameters = { title: "Hacked", brief: "FOR THE LULZ" }
  post "/users/#{some_user.id}/campaigns", crafted_parameters
end

# Then

Then(/^I should see (\d+) campaigns$/) do |count|
  all("tbody > tr").count.should == count.to_i
end

Then(/^I should see "(.*?)"$/) do |message|
  page.should have_content(message)
end

Then(/^"(.*?)" should have (\d+) campaigns$/) do |name, count|
  user = User.where(name: name).first
  user.campaigns.count == count.to_i
end

