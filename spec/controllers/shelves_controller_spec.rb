require "rails_helper"

RSpec.describe ShelvesController do
  let(:params) do
    {
      shelf: {
        title: 'To Read',
        user_id: 1
      }
    }
  end

  let(:current_user) { create(:user) }

  before do
    allow(controller).to receive(:current_user) { current_user }
  end

  describe "#create" do
    context "successfully" do
      it "creates a new shelf record" do
        expect do
          post :create, params: params
        end.to change { Shelf.count }.by(1)

        shelf = Shelf.last

        expect(shelf.title).to eql('To Read')
        expect(shelf.user).to eql(current_user)
      end
    end
    context "unsuccessfully" do
      it "does not create a new shelf" do
        expect do
          post :create, params: { shelf: { title: '' } }
        end.to change { Shelf.count }.by(0)
      end
    end
  end
end
