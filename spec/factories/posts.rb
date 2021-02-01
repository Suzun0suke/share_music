FactoryBot.define do
  factory :post do
    title              {Faker::Name.initials(number: 2)}
    url                {"https://open.spotify.com/playlist/6fx23lyt1F6jalDuo5BVZb"}
    tag_list               {"邦ロック, jrock"}
    association :user
    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/elle.jpg'),filename: 'elle.jpg')
    end
  end
end
