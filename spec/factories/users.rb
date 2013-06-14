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

    factory :agency do
      after(:create) { |user| user.add_role(:agency) }
    end
  end
end
