json.extract! administrator, :id, :name, :email, :password_digest, :created_at, :updated_at
json.url administrator_url(administrator, format: :json)
