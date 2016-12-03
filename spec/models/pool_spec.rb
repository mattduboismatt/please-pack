require "rails_helper"

RSpec.describe Pool do
  subject { build :pool }

  it "has a valid factory" do
    expect(subject.valid?).to eq true
    subject.save!
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :title }
  end

  describe "associations" do
    it { is_expected.to have_many :contestants }
  end
end
