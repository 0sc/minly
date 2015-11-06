# require 'rails_helper'
#
# RSpec.describe UrlsController, type: :controller do
#
#   # This should return the minimal set of attributes required to create a valid
#   # Url. As you add validations to Url, be sure to
#   # adjust the attributes here as well.
#   let(:valid_attributes) {
#     skip("Add a hash of attributes valid for your model")
#   }
#
#   let(:invalid_attributes) {
#     skip("Add a hash of attributes invalid for your model")
#   }
#
#   # This should return the minimal set of values that should be in the session
#   # in order to pass any filters (e.g. authentication) defined in
#   # UrlsController. Be sure to keep this updated too.
#   let(:valid_session) { {} }
#
#   describe "GET #index" do
#     it "assigns all urls as @urls" do
#       url = Url.create! valid_attributes
#       get :index, {}, valid_session
#       expect(assigns(:urls)).to eq([url])
#     end
#   end
#
#   describe "GET #show" do
#     it "assigns the requested url as @url" do
#       url = Url.create! valid_attributes
#       get :show, {:id => url.to_param}, valid_session
#       expect(assigns(:url)).to eq(url)
#     end
#   end
#
#   describe "GET #new" do
#     it "assigns a new url as @url" do
#       get :new, {}, valid_session
#       expect(assigns(:url)).to be_a_new(Url)
#     end
#   end
#
#   describe "GET #edit" do
#     it "assigns the requested url as @url" do
#       url = Url.create! valid_attributes
#       get :edit, {:id => url.to_param}, valid_session
#       expect(assigns(:url)).to eq(url)
#     end
#   end
#
#   describe "POST #create" do
#     context "with valid params" do
#       it "creates a new Url" do
#         expect {
#           post :create, {:url => valid_attributes}, valid_session
#         }.to change(Url, :count).by(1)
#       end
#
#       it "assigns a newly created url as @url" do
#         post :create, {:url => valid_attributes}, valid_session
#         expect(assigns(:url)).to be_a(Url)
#         expect(assigns(:url)).to be_persisted
#       end
#
#       it "redirects to the created url" do
#         post :create, {:url => valid_attributes}, valid_session
#         expect(response).to redirect_to(Url.last)
#       end
#     end
#
#     context "with invalid params" do
#       it "assigns a newly created but unsaved url as @url" do
#         post :create, {:url => invalid_attributes}, valid_session
#         expect(assigns(:url)).to be_a_new(Url)
#       end
#
#       it "re-renders the 'new' template" do
#         post :create, {:url => invalid_attributes}, valid_session
#         expect(response).to render_template("new")
#       end
#     end
#   end
#
#   describe "PUT #update" do
#     context "with valid params" do
#       let(:new_attributes) {
#         skip("Add a hash of attributes valid for your model")
#       }
#
#       it "updates the requested url" do
#         url = Url.create! valid_attributes
#         put :update, {:id => url.to_param, :url => new_attributes}, valid_session
#         url.reload
#         skip("Add assertions for updated state")
#       end
#
#       it "assigns the requested url as @url" do
#         url = Url.create! valid_attributes
#         put :update, {:id => url.to_param, :url => valid_attributes}, valid_session
#         expect(assigns(:url)).to eq(url)
#       end
#
#       it "redirects to the url" do
#         url = Url.create! valid_attributes
#         put :update, {:id => url.to_param, :url => valid_attributes}, valid_session
#         expect(response).to redirect_to(url)
#       end
#     end
#
#     context "with invalid params" do
#       it "assigns the url as @url" do
#         url = Url.create! valid_attributes
#         put :update, {:id => url.to_param, :url => invalid_attributes}, valid_session
#         expect(assigns(:url)).to eq(url)
#       end
#
#       it "re-renders the 'edit' template" do
#         url = Url.create! valid_attributes
#         put :update, {:id => url.to_param, :url => invalid_attributes}, valid_session
#         expect(response).to render_template("edit")
#       end
#     end
#   end
#
#   describe "DELETE #destroy" do
#     it "destroys the requested url" do
#       url = Url.create! valid_attributes
#       expect {
#         delete :destroy, {:id => url.to_param}, valid_session
#       }.to change(Url, :count).by(-1)
#     end
#
#     it "redirects to the urls list" do
#       url = Url.create! valid_attributes
#       delete :destroy, {:id => url.to_param}, valid_session
#       expect(response).to redirect_to(urls_url)
#     end
#   end
#
# end
