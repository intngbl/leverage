
### When

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

