FactoryGirl.define do
  factory :url do
    original  { Faker::Internet.url }
    shortened { Faker::Lorem.words }
    views     { rand(0..1000) }
  end
end
