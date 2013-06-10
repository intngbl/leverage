FactoryGirl.define do
  factory :user do
    name 'Fooser'
    email 'foo@leverage.com'
    password 'changeme'
    password_confirmation 'changeme'
    confirmed_at Time.now
  end
end
