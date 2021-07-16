FactoryBot.define do
  factory :item do
    title               { Faker::Name.name }
    text                { Faker::Lorem.sentence }
    category_id         { Faker::Number.between(from: 1, to: 10) }
    status_id           { Faker::Number.between(from: 1, to: 6) }
    delivery_fee_id     { Faker::Number.between(from: 1, to: 2) }
    prefecture_id       { Faker::Number.between(from: 1, to: 47) }
    delivery_date_id    { Faker::Number.between(from: 1, to: 3) }
    price               { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
