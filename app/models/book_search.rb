class BookSearch
  def initialize(query)
    @query = query
  end

  def call
    if @query
      Book.where('lower(title) LIKE ? OR lower(author) LIKE ? OR lower(description) LIKE ?',
                 "%#{@query.downcase}%", "%#{@query.downcase}%", "%#{@query.downcase}%")
    else
      Book.all
    end
  end
end
