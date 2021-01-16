require 'rails_helper'

RSpec.describe RecordError, :type => :model do
  let(:identifier) {
    Identifier.new(identifier: "foo")
  }
  subject {
    described_class.new(row: 0, text: "error message", identifier: identifier)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "requires identifier" do
    subject.identifier = nil
    expect(subject).to_not be_valid
  end

  it "requires integer row" do
    subject.row = nil
    expect(subject).to_not be_valid
  end

  it "requires text" do
    subject.text = ""
    expect(subject).to_not be_valid
  end

  it "requires text <= 255" do 
    subject.text = "a" * 254
    expect(subject).to be_valid
    subject.text += "a"
    expect(subject).to be_valid
    subject.text += "a"
    expect(subject).to_not be_valid
  end
end