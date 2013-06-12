FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Fooser-#{n}" }
    sequence(:email) { |n| "foo-#{n}@leverage.com" }
    password 'changeme'
    password_confirmation 'changeme'
    confirmed_at Time.now

    factory :unconfirmed_user do
      confirmed_at nil
    end
  end
end
