FactoryBot.define do
  factory :hanabi do
    user_id { 1 }
    title { "人混みを避けたスポットはここ" }
    body { "ここからは小さいけど丸いのが見える！　近くにカフェあるよ！" }
    image_id { "MyString" }
    address { "Faker::Address.street_address" }
    association :user
  end
end
