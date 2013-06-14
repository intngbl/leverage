# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :campaign do
    brief "The Virgin America experience is like no other airline's."
    price "9.99"
    title "Experience Virgin America"
    user
  end
end
