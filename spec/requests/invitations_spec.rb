require 'rails_helper'

RSpec.describe "Invitations", type: :request do
  include Devise::Test::IntegrationHelpers

  let!(:admin)   { FactoryBot.create(:administrator) }
  before { sign_in admin }

  let!(:company) { FactoryBot.create(:company) }
  let!(:user)    { FactoryBot.create(:user) }

  let!(:invitation) { FactoryBot.create(:invitation, company: company, user: user, active: true) }

  let(:valid_attributes) do
    {
      invitee_name: "New Invitee",
      invitee_email: "invitee@example.com",
      active: true,
      company_id: company.id,
      user_id: user.id
    }
  end

  let(:invalid_attributes) do
    {
      invitee_name: "",
      invitee_email: "invalid",
      active: nil,
      company_id: nil,
      user_id: nil
    }
  end

  describe "GET /companies/:company_id/invitations" do
    it "returns a successful response and lists invitations for a company" do
      get company_invitations_path(company)
      expect(response).to be_successful
    end
  end

  describe "GET /invitations/:id" do
    it "returns a successful response" do
      get invitation_path(invitation)
      expect(response).to be_successful
    end
  end

  describe "GET /companies/:company_id/invitations/new" do
    it "returns a successful response" do
      get new_company_invitation_path(company)
      expect(response).to be_successful
    end
  end

  describe "GET /invitations/:id/edit" do
    it "returns a successful response" do
      get edit_invitation_path(invitation)
      expect(response).to be_successful
    end
  end

  describe "POST /companies/:company_id/invitations" do
    context "with valid parameters" do
      it "creates a new Invitation" do
        expect {
          post company_invitations_path(company), params: { invitation: valid_attributes }
        }.to change(Invitation, :count).by(1)
      end

      it "redirects to the created invitation" do
        post company_invitations_path(company), params: { invitation: valid_attributes }
        new_invitation = Invitation.last
        expect(response).to redirect_to(invitation_path(new_invitation))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Invitation" do
        expect {
          post company_invitations_path(company), params: { invitation: invalid_attributes }
        }.not_to change(Invitation, :count)
      end

      it "renders the new template with unprocessable_entity status" do
        post company_invitations_path(company), params: { invitation: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /invitations/:id" do
    context "with valid parameters" do
      let(:new_attributes) { { invitee_name: "Updated Invitee", invitee_email: "updated@example.com" } }

      it "updates the requested invitation" do
        patch invitation_path(invitation), params: { invitation: new_attributes }
        invitation.reload
        expect(invitation.invitee_name).to eq("Updated Invitee")
        expect(invitation.invitee_email).to eq("updated@example.com")
      end

      it "redirects to the invitation" do
        patch invitation_path(invitation), params: { invitation: new_attributes }
        expect(response).to redirect_to(invitation_path(invitation))
      end
    end
  end
end