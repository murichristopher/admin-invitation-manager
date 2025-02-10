require 'rails_helper'

RSpec.describe "Companies", type: :request do
  include Devise::Test::IntegrationHelpers

  let!(:admin) { FactoryBot.create(:administrator) }
  before {     sign_in admin, scope: :administrator
 }

  let!(:company) { FactoryBot.create(:company) }
  let(:valid_attributes)   { { name: "New Company", address: "456 New Street" } }
  let(:invalid_attributes) { { name: "", address: "" } }

  describe "GET /companies" do
    it "returns a successful response and lists companies" do
      get companies_path
      expect(response).to be_successful
      expect(response.body).to include(company.name)
    end
  end

  describe "GET /companies/:id" do
    it "returns a successful response for the given company" do
      get company_path(company)
      expect(response).to be_successful
      expect(response.body).to include(company.address)
    end
  end

  describe "GET /companies/new" do
    it "returns a successful response" do
      get new_company_path
      expect(response).to be_successful
    end
  end

  describe "GET /companies/:id/edit" do
    it "returns a successful response" do
      get edit_company_path(company)
      expect(response).to be_successful
    end
  end

  describe "POST /companies" do
    context "with valid parameters" do
      it "creates a new Company" do
        expect {
          post companies_path, params: { company: valid_attributes }
        }.to change(Company, :count).by(1)
      end

      it "redirects to the created company" do
        post companies_path, params: { company: valid_attributes }
        expect(response).to redirect_to(company_path(Company.last))
      end
    end
  end

  describe "PATCH /companies/:id" do
    context "with valid parameters" do
      let(:new_attributes) { { name: "Updated Company", address: "789 Updated Ave" } }

      it "updates the requested company" do
        patch company_path(company), params: { company: new_attributes }
        company.reload
        expect(company.name).to eq("Updated Company")
        expect(company.address).to eq("789 Updated Ave")
      end

      it "redirects to the company" do
        patch company_path(company), params: { company: new_attributes }
        expect(response).to redirect_to(company_path(company))
      end
    end
  end

  describe "DELETE /companies/:id" do
    it "destroys the requested company" do
      company_to_destroy = FactoryBot.create(:company)
      expect {
        delete company_path(company_to_destroy)
      }.to change(Company, :count).by(-1)
    end

    it "redirects to the companies list" do
      delete company_path(company)
      expect(response).to redirect_to(companies_path)
    end
  end
end