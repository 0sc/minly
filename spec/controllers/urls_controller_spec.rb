require 'rails_helper'

RSpec.describe UrlsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Url. As you add validations to Url, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      original: Faker::Internet.url,
      shortened: Faker::Lorem.word + Faker::Lorem.word,
    }
  }

  let(:invalid_attributes) {
    {original: "htpp:\||andela.co."}
  }
  before(:each) do
    create(:user)
  end

  let(:valid_session) { {user_id: 1} }
#
  describe "GET #show" do
    it "assigns the requested url as @url" do
      url = Url.create! valid_attributes
      get :show, {:id => url.to_param}, valid_session
      expect(assigns(:url)).to eq(url)
    end

    it "returns error message for show query with invalid params" do
      url = Url.create! valid_attributes
      get :show, {:id => 100}, valid_session
      expect(assigns(:url)).not_to eq(url)
      expect(response).to redirect_to(dashboard_url)
    end
  end

#
  describe "POST #create" do
    context "with valid params" do
      it "creates a new Url" do
        expect {
          post :create, {:url => valid_attributes}, valid_session
        }.to change(Url, :count).by(1)
      end
      it "does not replicate a new Url" do
        post :create, {:url => valid_attributes}, valid_session
        expect {
          post :create, {:url => valid_attributes}, valid_session
        }.to change(Url, :count).by(0)
      end
      it "assigns a newly created url as @url" do
        post :create, {:url => valid_attributes}, valid_session
        expect(assigns(:url)).to be_a(Url)
        expect(assigns(:url)).to be_persisted
      end
      it "redirects to the dashboard for logged in user" do
        post :create, {:url => valid_attributes}, valid_session
        expect(response).to redirect_to(dashboard_url)
      end
      it "redirects to the index for logged in user" do
        post :create, {:url => valid_attributes}, {}
        expect(response).to redirect_to(root_path)
      end
    end
#
    context "with invalid params" do
      it "assigns a newly created but unsaved url as @url" do
        post :create, {:url => invalid_attributes}, valid_session
        expect(assigns(:url)).to be_a_new(Url)
      end
      it "redirects to the dashboard for logged in users" do
        post :create, {:url => invalid_attributes}, valid_session
        expect(response).to redirect_to(dashboard_url)
      end
      it "redirects to the index for regular in users" do
        post :create, {:url => invalid_attributes}, nil
        expect(response).to redirect_to(root_path)
      end
    end
  end
#
  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {active: false, original: "http://visit.me"}
      }
#
      it "updates the requested url" do
        url = Url.create! valid_attributes
        put :update, {:id => url.to_param, :url => new_attributes}, valid_session
        url.reload
        expect(url.active).to eq false
        expect(url.original).to eq "http://visit.me"
      end
#
      it "assigns the requested url as @url" do
        url = Url.create! valid_attributes
        put :update, {:id => url.to_param, :url => valid_attributes}, valid_session
        expect(assigns(:url)).to eq(url)
      end

      it "redirects to the dashboard" do
        url = Url.create! valid_attributes
        put :update, {:id => url.to_param, :url => valid_attributes}, valid_session
        expect(response).to redirect_to(dashboard_url)
      end
    end
#
    context "with invalid params" do
      it "assigns the url as @url unchanged" do
        url = Url.create! valid_attributes
        put :update, {:id => url.to_param, :url => invalid_attributes}, valid_session
        expect(assigns(:url)).to eq(url)
      end
#
      it "redirects to the dashboard" do
        url = Url.create! valid_attributes
        put :update, {:id => url.to_param, :url => invalid_attributes}, valid_session
        expect(response).to redirect_to(dashboard_url)
      end
    end
  end
#
  describe "DELETE #destroy" do
    context "with valid params" do
      it "destroys the requested url" do
        url = Url.create! valid_attributes
        expect {
          delete :destroy, {:id => url.to_param}, valid_session
        }.to change(Url, :count).by(-1)
      end

      it "redirects to the dashboard" do
        url = Url.create! valid_attributes
        delete :destroy, {:id => url.to_param}, valid_session
        expect(response).to redirect_to(dashboard_url)
      end
    end

    context "with invalid params" do
      it "doesn't destroy the requested url" do
        url = Url.create! valid_attributes
        expect {
          delete :destroy, {:id => 100}, valid_session
        }.to change(Url, :count).by(0)
      end

      it "returns error message for update query with invalid params" do
        url = Url.create! valid_attributes
        delete :destroy, {:id => 100}, valid_session
        expect(response).to redirect_to(dashboard_url)
      end
    end
  end
#
end
