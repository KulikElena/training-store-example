FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }

    trait :admin do
      admin { true }
    end
  end
end
