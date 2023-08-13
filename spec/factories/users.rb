FactoryBot.define do
  factory :user do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    age {Faker::Number.between(from: 18, to: 65)}
    date_of_birth {Faker::Date.birthday(min_age: 18, max_age: 65)}
    email {Faker::Internet.email}
    password {Faker::Internet.password}
  end
end
