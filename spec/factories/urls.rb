FactoryGirl.define do
  factory :url do
    original  { Faker::Internet.url }
    shortened { Faker::Lorem.word + Faker::Lorem.word }
    views { Faker::Number.between(1, 1000) }

    factory :registered_users_url do
      user_id { Faker::Number.between(0, 10) }
    end
  end
end
