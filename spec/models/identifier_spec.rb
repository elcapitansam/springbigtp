require 'rails_helper'

RSpec.describe Identifier, :type => :model do
  subject {
    described_class.new(identifier: "foo")
  }

  it "requires identifier" do
    subject.identifier = nil
    expect(subject).to_not be_valid
    subject.identifier = ""
    expect(subject).to_not be_valid
  end
end