# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tweet do
    body "Gotta check this!"
    tweeted_at Time.now()
  end
end
