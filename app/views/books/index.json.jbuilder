json.array! @books do |book|
  json.title book.title
  json.author book.author
  json.release_year book.release_year
  json.description book.description
  json.page_count book.page_count
end
