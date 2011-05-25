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
  
  test "Test vote" do
    voter = Factory(:user)
    t = Factory(:topic_with_author)
    
    assert_equal 1, voter.score
    assert_equal 1, t.author.score
    assert_equal 0, t.score
    
    assert_nothing_raised do
      Vote.make(voter, t, 1)
    end
    
    assert_equal 0, voter.score
    assert_equal 2, t.author.score
    assert_equal 1, t.score
    
    assert_not_nil voter.voted_items.index(t)
    assert_not_nil t.voted_users.index(voter)
    
    # Author cannot vote himself
    assert_raise RuntimeError do
      Vote.make(t.author, t, 1)
    end
    
    # Transaction will rollback
    assert_equal 2, t.author.score
    assert_equal 1, t.score
  end
  
  test "Test negative vote" do
    voter = Factory(:user)
    t = Factory(:topic_with_author)
    
    assert_nothing_raised do
      Vote.make(voter, t, -1)
    end
    
    assert_equal 0, voter.score
    assert_equal 0, t.author.score
    assert_equal -1, t.score
    
    assert_not_nil voter.voted_items.index(t)
    assert_not_nil t.voted_users.index(voter)
  end
  
  test "Test invalid amount vote" do
    voter = Factory(:user)
    t1 = Factory(:topic_with_author)
    t2 = Factory(:topic_with_author)  
    
    Vote.make(voter, t1, 1)
    
    assert_raise RuntimeError do
      Vote.make(voter, t2, 1)
    end
    
    assert_raise RuntimeError do
      Vote.make(voter, t2, -1)
    end
  end
end
