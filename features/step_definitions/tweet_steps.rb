### When

When(/^I go to the list of "(.*?)" tweets$/) do |title|
  @campaign = Campaign.where(title: title).first
  visit campaign_tweets_path(@campaign)
end

