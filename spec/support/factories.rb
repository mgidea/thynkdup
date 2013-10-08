FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@factory.com" }
    password "password"
    password_confirmation "password"
    first_name "Tom"
    last_name "Corley"
  end
end

FactoryGirl.define do
  factory :nutshell do
    sequence(:title) {|n|"nutshell name#{n}"}
    content "I want to make nutshells"
    association :user
  end
end
