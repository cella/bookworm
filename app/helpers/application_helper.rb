module ApplicationHelper
  def available_shelves_for(book)
    shelves = current_user.shelves
    shelves = shelves.reject do |shelf|
      shelf.books.include?(book)
    end
    options_from_collection_for_select(shelves, :id, :title)
  end
end
