# spec/requests/administrators_spec.rb
require 'rails_helper'

RSpec.describe "Administrators", type: :request do
  include Devise::Test::IntegrationHelpers

  let!(:administrator) { FactoryBot.create(:administrator) }
  let(:valid_attributes) do
    { name: "Jane Doe", email: "jane@example.com", password: "password", password_confirmation: "password" }
  end
  let(:invalid_attributes) do
    { name: "", email: "invalid", password: "short", password_confirmation: "different" }
  end

  before do
    sign_in administrator, scope: :administrator
  end

  describe "GET /administrators" do
    it "returns a successful response and lists administrators" do
      get administrators_path
      expect(response).to be_successful
      expect(response.body).to include(administrator.name)
    end
  end

  describe "GET /administrators/:id" do
    it "returns a successful response for the given administrator" do
      get administrator_path(administrator)
      expect(response).to be_successful
      expect(response.body).to include(administrator.email)
    end
  end

  describe "GET /administrators/new" do
    it "returns a successful response" do
      get new_administrator_path
      expect(response).to be_successful
    end
  end

  describe "GET /administrators/:id/edit" do
    it "returns a successful response" do
      get edit_administrator_path(administrator)
      expect(response).to be_successful
    end
  end

  describe "POST /administrators" do
    context "with valid parameters" do
      it "creates a new Administrator" do
        expect {
          post administrators_path, params: { administrator: valid_attributes }
        }.to change(Administrator, :count).by(1)
      end

      it "redirects to the created administrator" do
        post administrators_path, params: { administrator: valid_attributes }
        expect(response).to redirect_to(administrator_path(Administrator.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Administrator" do
        expect {
          post administrators_path, params: { administrator: invalid_attributes }
        }.not_to change(Administrator, :count)
      end

      it "returns an unprocessable entity status" do
        post administrators_path, params: { administrator: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /administrators/:id" do
    context "with valid parameters" do
      let(:new_attributes) { { name: "Updated Name", email: "updated@example.com" } }

      it "updates the requested administrator" do
        patch administrator_path(administrator), params: { administrator: new_attributes }
        administrator.reload
        expect(administrator.name).to eq("Updated Name")
        expect(administrator.email).to eq("updated@example.com")
      end

      it "redirects to the administrator" do
        patch administrator_path(administrator), params: { administrator: new_attributes }
        expect(response).to redirect_to(administrator_path(administrator))
      end
    end

    context "with invalid parameters" do
      it "returns an unprocessable entity status" do
        patch administrator_path(administrator), params: { administrator: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /administrators/:id" do
    it "destroys the requested administrator" do
      expect {
        delete administrator_path(administrator)
      }.to change(Administrator, :count).by(-1)
    end

    it "redirects to the administrators list" do
      delete administrator_path(administrator)
      expect(response).to redirect_to(administrators_path)
    end
  end
end
