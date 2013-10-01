FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "tom#{n}@gmail.com" }
    password "password"
    password_confirmation "password"
    first_name "Tom"
    last_name "Corley"
  end
end
