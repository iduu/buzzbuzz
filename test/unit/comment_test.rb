require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  should validate_presence_of(:parent)
  should_not validate_presence_of(:title)
  should_not validate_presence_of(:url)
end
