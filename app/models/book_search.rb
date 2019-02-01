class BookSearch
  def initialize(query)
    @query = query
  end

  def call
    if @query
      Book.where('lower(title) LIKE ?', "%#{@query.downcase}%")
    else
      Book.all
    end
  end
end
