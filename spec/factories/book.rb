FactoryBot.define do
  factory :book do
    title { 'The Great Gatsby' }
    author { 'F. Scott Fitzgerald' }
    page_count { 180 }
    description { "This is a cool book" }
    release_year { 1925 }
  end
end
