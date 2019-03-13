require "rails_helper"

RSpec.describe "Requests - Delete Book" do
  let(:user) { create(:user) }

  let(:headers) do
    {
      "ACCEPT" => "application/json",
      "Authorization" => user.token
    }
  end

  describe "DELETE /books/:id" do
    let!(:book) { create(:book) }

    it "deletes a book" do
      expect do
        delete "/books/#{ book.id }", headers: headers
      end.to change { Book.count }.by(-1)
    end

    it "success" do
      delete "/books/#{ book.id }", headers: headers
      expect(response.status).to eql 200
    end

    context "when the request is not authenticated" do
      let(:headers) do
        {
          "ACCEPT" => "application/json",
        }
      end

      it "fails to delete book" do
        expect do
          delete "/books/#{ book.id }", headers: headers
        end.to change { Book.count }.by(0)
      end

      it "returns a 401 unauthorized" do
        delete "/books/#{ book.id }", headers: headers

        expect(response.status).to eql 401
      end
    end
  end
end

