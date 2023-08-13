FactoryBot.define do
  factory :book do
    name { "MyString" }
    description { "MyText" }
    user { nil }
    number_of_copy { 1 }
    status { "MyString" }
    note { "MyText" }
    likes { 1 }
  end
end
