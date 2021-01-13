FactoryBot.define do
  factory :user do
    name              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              {"abc1111"}
    password_confirmation {password}
    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/elle.jpg'),filename: 'elle.jpg')
    end
  end
end
