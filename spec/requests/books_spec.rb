require "rails_helper"

RSpec.describe "Requests - Books" do
  let(:headers) do
    {
      "ACCEPT" => "application/json"
    }
  end

  describe "GET /books" do
    let!(:books) { create_list(:book, 5, :random) }

    it "returns a list of the books" do
      get "/books", headers: headers

      res_json = JSON.parse(response.body)
      expect(res_json.count).to be(5)
      expect(res_json.map { |item| item["title"] }).to eql(books.map(&:title))
      expect(res_json[0]["author"]).to eql(books[0].author)
      expect(res_json[0]["page_count"]).to eql(books[0].page_count)
      expect(res_json[0]["description"]).to eql(books[0].description)
      expect(res_json[0]["release_year"]).to eql(books[0].release_year)
    end

    context "with a search param" do
      it "filters the results" do
        get "/books", params: { query: books.first.title }, headers: headers

        res_json = JSON.parse(response.body)
        expect(res_json.count).to be(1)
        expect(res_json[0]["title"]).to eql(books[0].title)
        expect(res_json[0]["author"]).to eql(books[0].author)
        expect(res_json[0]["page_count"]).to eql(books[0].page_count)
        expect(res_json[0]["description"]).to eql(books[0].description)
        expect(res_json[0]["release_year"]).to eql(books[0].release_year)
      end
    end
  end

  describe "GET /book" do
    let(:book) { create(:book) }

    it "returns a book" do
      get "/books/#{ book.id }", headers: headers

      res_json = JSON.parse(response.body)
      expect(res_json["title"]).to eql(book.title)
      expect(res_json["author"]).to eql(book.author)
      expect(res_json["page_count"]).to eql(book.page_count)
      expect(res_json["description"]).to eql(book.description)
      expect(res_json["release_year"]).to eql(book.release_year)
    end
  end
end
