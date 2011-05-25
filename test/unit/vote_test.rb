require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "Test vote validation" do
    v = Vote.new
    assert v.invalid?
    
    assert v.errors[:user].any?
    assert v.errors[:item].any?
    assert !v.errors[:score].any?
  end
end
