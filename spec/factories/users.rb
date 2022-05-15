FactoryBot.define do
  factory :user do
    user_name { Faker::Name.name }
    sequence(:email) { |n| "example#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    profile { 'はじめまして' }

    trait :admin do
      admin { true }
    end
  end
end
