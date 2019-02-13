require "rails_helper"

RSpec.describe ShelvesController do
  let(:params) do
    {
      user_id: 1,
      shelf: {
        title: 'To Read',
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
          post :create, params: { user_id: current_user.id, shelf: { title: '' } }
        end.to change { Shelf.count }.by(0)
      end
    end
  end

  describe "#update" do
    context "with another user's shelf" do
      let(:shelf) { create(:shelf) }

      let(:params) do
        { user_id: shelf.user.id, id: shelf.id, shelf: { title: 'New Title' } }
      end

      it "redirects to root path" do
        post :update, params: params

        expect(flash[:alert]).to be_present
        expect(response).to redirect_to("/")
      end

      it "does not update the shelf" do
        post :update, params: params

        shelf.reload
        expect(shelf.title).to_not eql('New Title')
      end
    end
  end
end
