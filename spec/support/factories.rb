FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@factory.com" }
    password "foobar"
    password_confirmation "foobar"
  end
end

FactoryGirl.define do
  factory :nutshell do
    title "nutshell name"
    content "I want to make nutshells"
    user
  end
end
