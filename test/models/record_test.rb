require "test_helper"

class RecordTest < ActiveSupport::TestCase
  def setup
    @record = Records.new(row: 0, email: "me@email.com", 
                          phone: "123.456.7890",
                          first: "Firstname", last: "Lastname")
  end

  test "setup is valid" do
    assert @record.valid?
  end

  test "email should be present" do
    @record.email = ""
    assert_not @record.valid?
  end

  test "email validation accepts valid addresses" do
    valid = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
               first.last@foo.jp me+bobbymcgee@baz.cn]
    valid.each { |email|
      @record.email = email
      assert @record.valid?, "#{email.inspect} should be valid"
    }
  end

  test "email validation rejects invalid addresses" do
    invalid = %w[user@example,com user_at_foo.org user.name@example.
                  foo@bar_baz.com foo@bar+baz.com foo@bar..com foo@b
                  foo@bar.b]
    invalid.each { |_email|
      @record.email = _email
      assert_not @record.valid?, "#{_email.inspect} should be invalid"
    }
  end

  test "size limits on phone" do
    @record.phone = "a"*255
    assert_not @record.valid?
  end
end
