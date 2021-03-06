FactoryBot.define do
  factory :book do
    title { 'The Great Gatsby' }
    author { 'F. Scott Fitzgerald' }
    page_count { 180 }
    description { "This is a cool book" }
    release_year { 1925 }

    trait :anna do
      title { 'Anna Karenina' }
      author { 'Leo Tolstoy' }
      page_count { 964 }
      description { "This is an ever cooler book" }
      release_year { 1877 }
    end

    trait :random do
      title { Faker::Book.title }
      author { Faker::Book.author }
      page_count { rand(50..800) }
      description { Faker::Lorem.sentence }
      release_year { rand(1377..Time.current.year) }
    end
  end
end
