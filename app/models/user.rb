class User < ApplicationRecord
  has_many :invitations, dependent: :nullify
end
