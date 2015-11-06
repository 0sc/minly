FactoryGirl.define do
  factory :user do
    provider {"facebook"}
    uid  { Faker::Number.number(5) }
    name  { Faker::Name.name }
    oauth_token { Faker::Number.number(8) }
    token { SecureRandom.urlsafe_base64(32) }
  end
end
