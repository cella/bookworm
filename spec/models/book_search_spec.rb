require 'rails_helper'

RSpec.describe BookSearch do
  subject(:search) { described_class.new(query) }

  let(:query) { "gatsby" }

  describe "#call" do
    let!(:gatsby) { create(:book) }
    let!(:sad_gatsby) { create(:book, title: "the sad gatsby", author: "T. Money") }
    let!(:anna) { create(:book, :anna) }

    it "returns books with a similar title" do
      expect(search.call).to contain_exactly(gatsby, sad_gatsby)
    end

    context "when query is nil" do
      let(:query) { nil }

      it "returns all of the books" do
        expect(search.call).to contain_exactly(gatsby, sad_gatsby, anna)
      end
    end

    context "when query doesn't return results" do
      let(:query) { "rad book" }

      it "returns an empty list" do
        expect(search.call).to be_empty
      end
    end

    context "when query includes author" do
      let(:query) { "F. Scott Fitzgerald" }

      it "returns books with a similar author" do
        expect(search.call).to contain_exactly(gatsby)
      end
    end

    context "when query includes description" do
      let(:query) { "cooler" }

      it "returns books with a similar description" do
        expect(search.call).to contain_exactly(anna)
      end
    end
  end
end
