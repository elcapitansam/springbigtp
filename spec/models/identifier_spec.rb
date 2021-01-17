require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Identifier, :type => :model do
  subject {
    described_class.new(identifier: "foo1234")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "requires identifier" do
    subject.identifier = nil
    expect(subject).to_not be_valid
    subject.identifier = ""
    expect(subject).to_not be_valid
  end

  it "requires identifier.length in 2..255" do
    subject.identifier = "a"
    expect(subject).to_not be_valid

    subject.identifier = "aa"
    expect(subject).to be_valid

    subject.identifier = "a"*255
    expect(subject).to be_valid

    subject.identifier = "a"*256
    expect(subject).to_not be_valid
  end

  it "only permits alphanumeric identifiers" do
    valid = (("A".."Z").to_a + ('a'..'z').to_a + ('0'..'9').to_a).join

    subject.identifier = valid
    expect(subject).to be_valid

    each_printable_char_except_in(valid) { |ch|
      subject.identifier = valid + ch
      expect(subject).to_not be_valid
    }
  end
end