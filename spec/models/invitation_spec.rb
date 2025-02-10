require 'rails_helper'

RSpec.describe Invitation, type: :model do
  subject { FactoryBot.build(:invitation) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it { should belong_to(:company) }
  it { should belong_to(:user) }
end