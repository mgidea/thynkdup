FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@factory.com" }
    password "password"
    password_confirmation "password"
    sequence(:first_name) {|n| "Tom#{n}"}
    sequence(:last_name) {|n| "Corley#{n}"}
  end

  factory :nutshell do
    sequence(:title) {|n|"nutshell name#{n}"}
    content "I want to make nutshells"
    user
  end

  factory :category do
    sequence(:name) {|n| "art#{n}"}
  end

  factory :note do
    sequence(:title) {|n| "name#{n}"}
    content "I am going to make more note"
    nutshell
  end
end
