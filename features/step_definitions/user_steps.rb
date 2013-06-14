### UTILITY METHODS ###

def create_visitor
  @visitor ||= { :name => "Testy McUserton", :email => "example@example.com",
    :password => "changeme", :password_confirmation => "changeme" }
end

def find_user
  @user ||= User.where(:email => @visitor[:email]).first
end

def create_unconfirmed_user
  create_visitor
  delete_user
  sign_up
  visit '/users/sign_out'
end

def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, @visitor)
end

def create_random_user
  @user = FactoryGirl.create(:user)
end

def create_roles
  YAML.load(ENV['ROLES']).each do |role|
    Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  end
end

def delete_user
  @user ||= User.where(:email => @visitor[:email]).first
  @user.destroy unless @user.nil?
end

def edit_user(user)
  visit '/users'
  find("a[href='#role-options-#{user.id}']").click
  choose("user_role_ids_2")
  within(".modal-footer") do
    click_button("Change Role")
  end
end

def sign_up
  delete_user
  visit '/users/sign_up'
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

def sign_in(user = @visitor)
  visit '/users/sign_in'
  fill_in "user_email", :with => user[:email]
  fill_in "user_password", :with => user[:password]
  click_button "Sign in"
end

### GIVEN ###

Given /^Roles are defined$/ do
  create_roles
end

Given /^I am not logged in$/ do
  visit '/users/sign_out'
end

Given /^I am logged in$/ do
  create_user
  sign_in
end

Given /^I am logged in as admin$/ do
  create_user
  @user.add_role(:admin)
  sign_in
end

Given /^I exist as a user$/ do
  create_user
  sign_in
end

Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end

Given /^I exist as an unconfirmed user$/ do
  create_unconfirmed_user
end

Given /^I am $/ do
  create_unconfirmed_user
end

Given(/^Another random user exist$/) do
  create_random_user
end

### WHEN ###

When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end

When /^I sign out$/ do
  visit '/users/sign_out'
end

When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end

When /^I sign up with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(:email => "notanemail")
  sign_up
end

When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "changeme123")
  sign_up
end

When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end

When /^I edit my account details$/ do
  click_link "Edit account"
  fill_in "user_name", :with => "newname"
  fill_in "user_current_password", :with => @visitor[:password]
  click_button "Update"
end

When /^I look at the list of users$/ do
  visit '/users'
end

When(/^I edit that user's role$/) do
  edit_user @user
end

When(/^I follow the confirmation link$/) do
  visit "/users/confirmation?confirmation_token=#{@user.confirmation_token}"
end

When(/^Confirm my account$/) do
  click_button I18n.t("devise.confirmations.show.confirm_account")
end

When(/^Select my role as (\w+)/) do |role_name|
  role = Role.where(name: role_name).first
  # Check if someone is cheating
  if role.present? && role_name != 'admin'
    select(role_name.titleize, from: "user_role_ids")
  end
end

### THEN ###

Then /^I should be signed in$/ do
  page.should have_content "Logout"
  page.should_not have_content "Sign up"
  page.should_not have_content "Login"
end

Then /^I should be signed out$/ do
  page.should have_content "Sign up"
  page.should have_content "Login"
  page.should_not have_content "Logout"
end

Then /^I see an unconfirmed account message$/ do
  page.should have_content "You have to confirm your account before continuing."
end

Then /^I see a successful sign in message$/ do
  page.should have_content "Signed in successfully."
end

Then /^I should see a successful sign up message$/ do
  page.should have_content "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."
end

Then /Î should see a successful account confirmation message$/ do
  page.should have_content "Your account was successfully confirmed. You are now signed in."
end

Then /^I should see an invalid email message$/ do
  page.should have_content "Emailis invalid"
end

Then /^I should see a missing password message$/ do
  page.should have_content "Passwordcan't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Passworddoesn't match confirmation"
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Passworddoesn't match confirmation"
end

Then /^I should see a signed out message$/ do
  page.should have_content "Signed out successfully."
end

Then /^I see an invalid login message$/ do
  page.should have_content "Invalid email or password."
end

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully."
end

Then /^I should see an user updated message$/ do
  page.should have_content "User updated."
end

Then /^I should see my name$/ do
  page.should have_content @user[:name]
end

Then(/^My role should be (\w+)/) do |role_name|
  role = Role.where(name: role_name).first
  assert @user.roles.include?(role)
end

