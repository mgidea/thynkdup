FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@factory.com" }
    password "password"
    password_confirmation "password"
    first_name "Tom"
    last_name "Corley"
  end

  factory :nutshell do
    sequence(:title) {|n|"nutshell name#{n}"}
    content "I want to make nutshells"
    user
  end

  factory :category do
    name "art"
  end
end
