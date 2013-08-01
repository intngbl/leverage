Given(/^"(.*?)" "(.*?)" a message to "(.*?)"$/) do |sender, action, receiver|
  s = User.where(name: sender).first
  r = User.where(name: receiver).first
  if action == "sent"
    s.send_message(r, "Lorem ipsum", "Hey!")
  end
end

When(/^I go to my conversations$/) do
  visit '/conversations'
end

