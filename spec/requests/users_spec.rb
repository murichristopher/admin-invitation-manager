require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { FactoryBot.create(:user) }

  let(:valid_attributes) { { name: "New User", email: "newuser@example.com" } }
  let(:invalid_attributes) { { name: "", email: "" } }
  let!(:admin)   { FactoryBot.create(:administrator) }
  before { sign_in admin }

  describe "GET /users" do
    it "returns a successful response and lists users" do
      get users_path
      expect(response).to be_successful
      expect(response.body).to include(user.name)
    end
  end

  describe "GET /users/:id" do
    it "returns a successful response for the given user" do
      get user_path(user)
      expect(response).to be_successful
      expect(response.body).to include(user.email)
    end
  end

  describe "GET /users/new" do
    it "returns a successful response" do
      get new_user_path
      expect(response).to be_successful
    end
  end

  describe "GET /users/:id/edit" do
    it "returns a successful response" do
      get edit_user_path(user)
      expect(response).to be_successful
    end
  end

  describe "POST /users" do
    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post users_path, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "redirects to the created user" do
        post users_path, params: { user: valid_attributes }
        expect(response).to redirect_to(user_path(User.last))
      end
    end
  end

  describe "PATCH /users/:id" do
    context "with valid parameters" do
      let(:new_attributes) { { name: "Updated User", email: "updateduser@example.com" } }

      it "updates the requested user" do
        patch user_path(user), params: { user: new_attributes }
        user.reload
        expect(user.name).to eq("Updated User")
        expect(user.email).to eq("updateduser@example.com")
      end

      it "redirects to the user" do
        patch user_path(user), params: { user: new_attributes }
        expect(response).to redirect_to(user_path(user))
      end
    end
  end

  describe "DELETE /users/:id" do
    it "destroys the requested user" do
      user_to_destroy = FactoryBot.create(:user)
      expect {
        delete user_path(user_to_destroy)
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      delete user_path(user)
      expect(response).to redirect_to(users_path)
    end
  end
end