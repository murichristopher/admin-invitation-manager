require 'rails_helper'

RSpec.describe Company, type: :model do
  subject { FactoryBot.build(:company) }

  it { should have_many(:invitations).dependent(:destroy) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end