json.extract! invitation, :id, :invitee_name, :invitee_email, :active, :company_id, :created_at, :updated_at
json.url invitation_url(invitation, format: :json)
