module TopicsHelper
  def tree_count(item, is_root = true)
    result = is_root ? 0 : 1
    item.children.each do |x|
      result += tree_count x, false
    end
    result
  end
end
