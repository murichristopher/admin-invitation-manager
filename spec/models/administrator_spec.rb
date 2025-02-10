require 'rails_helper'

RSpec.describe Administrator, type: :model do
  subject do
    FactoryBot.build(:administrator)
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without an email" do
    subject.email = nil
    expect(subject).not_to be_valid
  end

  it "is not valid with a duplicate email" do
    FactoryBot.create(:administrator, email: subject.email)
    expect(subject).not_to be_valid
  end

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_presence_of(:password) }
end