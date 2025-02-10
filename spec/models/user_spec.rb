require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.build(:user) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it { should have_many(:invitations).dependent(:nullify) }
end