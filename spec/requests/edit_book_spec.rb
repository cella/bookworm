require "rails_helper"

RSpec.describe "Requests - Edit Book" do
  let(:user) { create(:user) }

  let(:headers) do
    {
      "ACCEPT" => "application/json",
      "Authorization" => user.token
    }
  end

  describe "PUT /books/:id" do
    let(:book) { create(:book) }
    let(:params) do
      {
        book: {
          title: "Even better title",
          description: "Sweet book",
          release_year: 2018,
          page_count: 22,
          author: "Blues Clues"
        }
      }
    end

    it "updates a book" do
      put "/books/#{ book.id }", params: params, headers: headers

      expect(response.status).to eql 200

      res_json = JSON.parse(response.body)
      expect(res_json["title"]).to eql("Even better title")

      book.reload
      expect(book.title).to eq("Even better title")
    end

    context "when the new books attrs are invalid" do
      let(:params) do
        {
          book: {
            title: nil
          }
        }
      end

      it "does not update the book and responds with errors" do
        put "/books/#{ book.id }", params: params, headers: headers

        expect(response.status).to eql 422

        res_json = JSON.parse(response.body)
        expect(res_json["errors"]).to be_present
        expect(res_json["errors"]["title"]).to contain_exactly("can't be blank")

        book.reload
        expect(book.title).to eq("The Great Gatsby")
      end
    end

    context "when the request is not authenticated" do
      let(:headers) do
        {
          "ACCEPT" => "application/json",
        }
      end

      it "returns a 401 unauthorized" do
        put "/books/#{ book.id }", params: params, headers: headers

        expect(response.status).to eql 401

        book.reload
        expect(book.title).to eq("The Great Gatsby")
      end
    end
  end
end
