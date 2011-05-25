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
  
  test "User's author-item relation" do
    u = Factory(:user)
    t = Factory(:topic, :author => u)
    c = Factory(:comment, :author => u, :parent => t)
    
    assert_not_nil u.submits.index(t) # must exist in author's submits
    assert_equal u, t.author # author must be user
    
    assert_not_nil u.submits.index(c)
    assert_equal u, c.author
  end
  
  test "Item's parent-child relation" do
    u = Factory(:user)
    t = Factory(:topic, :author => u)
    c = Factory(:comment, :author => u, :parent => t)

    assert_not_nil t.children.index(c)
    assert_equal c.parent, t
  end
end
