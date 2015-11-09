require 'rails_helper'

RSpec.describe RerouteController, type: :controller do
  describe "GET #index" do
    before(:each) do
      @url = create(:url, shortened: "valid", original: "http://minly.herokuapp.com")
    end
    context "valid minly" do
      it "saves the view" do
        get :index, {path: "valid"}
        expect(Url.find_by(@url.id).views).to eql @url.views + 1
      end

      it "redirects valid minly to the original url" do
        get :index, {path: "valid"}
        expect(response).to redirect_to("http://minly.herokuapp.com")
      end
    end

    context "inactive minly" do
      before(:each) { @url.update_attributes(active: false) }
      it "does not redirect inactive url" do
        get :index, {path: "valid"}
        expect(response).not_to redirect_to("http://minly.herokuapp.com")
      end

      it "redirects logged in users to dashboard" do
        user = create(:user)
        get :index, {path: "valid"}, {user_id: user.id}
        expect(response).to redirect_to dashboard_url
      end

      it "redirects regular users to index page" do
        get :index, {path: "valid"}
        expect(response).to redirect_to root_path
      end
    end

    context "deleted minly" do
      before(:each) { @url.delete}
      it "does not redirect deleted minly" do
        get :index, {path: "valid"}
        expect(response).not_to redirect_to("http://minly.herokuapp.com")
      end
      it "redirects logged in users to dashboard" do
        user = create(:user)
        get :index, {path: "valid"}, {user_id: user.id}
        expect(response).to redirect_to dashboard_url
      end

      it "redirects regular users to index page" do
        get :index, {path: "valid"}
        expect(response).to redirect_to root_path
      end
    end

    context "invalid minly" do
      it "does not redirect invalid minly" do
        get :index, {path: "invalid"}
        expect(response).not_to redirect_to("http://minly.herokuapp.com")
      end
      it "redirects logged in users to dashboard" do
        user = create(:user)
        get :index, {path: "invalid"}, {user_id: user.id}
        expect(response).to redirect_to dashboard_url
      end

      it "redirects regular users to index page" do
        get :index, {path: "invalid"}
        expect(response).to redirect_to root_path
      end
    end
  end
end
