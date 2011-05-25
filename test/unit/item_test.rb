require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "Test item validation" do
    i = Item.new
    assert i.invalid?
    
    assert i.errors[:author].any?
    assert i.errors[:text].any?
  end
  
  test "Test topic validation" do
    t = Topic.new
    assert t.invalid?
    
    assert !t.errors[:parent].any?
    assert t.errors[:title].any?
    assert t.errors[:url].any?
  end
  
  test "Test comment validation" do
    c = Comment.new
    assert c.invalid?
    
    assert c.errors[:parent].any?
    assert !c.errors[:title].any?
    assert !c.errors[:url].any?
  end
end
