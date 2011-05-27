require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  should_not validate_presence_of(:parent)
  should validate_presence_of(:title)
  should validate_presence_of(:url)
  
  context "A topic" do
    setup do
      @user = Factory(:user)
      @topic = Factory(:topic, :author => @user)
      @comment = Factory(:comment, :author => @user, :parent => @topic)
    end
    
    should "be in its author's submit" do
      assert_not_nil @user.submits.index(@topic) # must exist in author's submits
      assert_equal @user, @topic.author # author must be user
    
      assert_not_nil @user.submits.index(@comment)
      assert_equal @user, @comment.author
    end
  
    should "be the parent of its comment" do
      assert_not_nil @topic.children.index(@comment)
      assert_equal @comment.parent, @topic
    end
  end
end
