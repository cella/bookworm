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
    end

    context "with a search param" do
      it "filters the results" do
        get "/books", params: { query: books.first.title }, headers: headers

        res_json = JSON.parse(response.body)
        expect(res_json.count).to be(1)
        expect(res_json[0]["title"]).to eql(books[0].title)
        expect(res_json[0]["author"]).to eql(books[0].author)
      end
    end
  end
end
