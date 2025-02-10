class Company < ApplicationRecord
  has_many :invitations, dependent: :destroy
end
