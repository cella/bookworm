require "rails_helper"

RSpec.describe "Requests - Create Book" do
  let(:user) { create(:user) }

  let(:headers) do
    {
      "ACCEPT" => "application/json",
      "Authorization" => user.token
    }
  end

  describe "POST /books" do
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

    it "creates a book" do
      post "/books", params: params, headers: headers

      expect(response.status).to eql 200

      res_json = JSON.parse(response.body)
      expect(res_json["title"]).to eql("Even better title")
      expect(Book.last.title).to eql("Even better title")
    end

    context "when the new books attrs are invalid" do
      let(:params) do
        {
          book: {
            title: nil
          }
        }
      end

      it "does not create the book and responds with errors" do
        post "/books", params: params, headers: headers

        expect(response.status).to eql 422

        res_json = JSON.parse(response.body)
        expect(res_json["errors"]).to be_present
        expect(res_json["errors"]["title"]).to contain_exactly("can't be blank")
      end
    end

    context "when the request is not authenticated" do
      let(:headers) do
        {
          "ACCEPT" => "application/json",
        }
      end

      it "returns a 401 unauthorized" do
        post "/books", params: params, headers: headers

        expect(response.status).to eql 401
      end
    end
  end
end

