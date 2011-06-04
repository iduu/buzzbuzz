require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  should "Test vote validation" do
    v = Vote.new
    assert v.invalid?
    
    assert v.errors[:user].any?
    assert v.errors[:item].any?
    assert !v.errors[:score].any?
  end
  
  context "A vote" do
    setup do
      @voter = Factory(:user)
      @topic = Factory(:topic_with_author)
      @another = Factory(:topic_with_author)
    end
    
    should "perform between a user and a topic" do
      voter = @voter
      t = @topic
    
      assert_equal 1, voter.score
      assert_equal 1, t.author.score
      assert_equal 0, t.score
    
      assert_nothing_raised do
        Vote.make(voter, t, 1)
      end
    
      assert_equal 1, voter.score
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
  
    should "be negative" do
      voter = @voter
      t = @topic
    
      assert_nothing_raised do
        Vote.make(voter, t, -1)
      end
    
      assert_equal 1, voter.score
      assert_equal 0, t.author.score
      assert_equal -1, t.score
    
      assert_not_nil voter.voted_items.index(t)
      assert_not_nil t.voted_users.index(voter)
    end
  
    should "refuse invalid amount" do
      voter = @voter
      t1 = @topic
      t2 = @another
    
      assert_raise RuntimeError do
        Vote.make(voter, t2, -10)
      end
    end
  
    should "refuse duplicate" do
      voter = @voter
      t1 = @topic

      assert_nothing_raised do
        Vote.make(voter, t1, 1)
      end
    
      vote =Vote.make(voter, t1, 1)
      assert vote.errors.any?
    end
  end
end
