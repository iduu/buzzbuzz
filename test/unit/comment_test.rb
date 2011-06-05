require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  should validate_presence_of(:parent)
  should_not validate_presence_of(:title)
  should_not validate_presence_of(:url)
  
  context "A comment" do
    setup do
      @user = Factory(:user)
      @topic = Factory(:topic, :author => @user)
      @comment = Factory(:comment, :author => @user, :parent => @topic)
    end
    
    should "be in the users's comments" do
      assert_not_nil @user.comments.index(@comment)
      assert_equal @user, @comment.author
    end
  end
end
