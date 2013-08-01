
### When

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in(field, with: value)
end

When(/^I press "(.*?)"$/) do |button_title|
  click_button(button_title)
end

