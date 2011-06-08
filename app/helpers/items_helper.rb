module ItemsHelper
  def render_tree(item, level = 1)
    children = item.children
    children = Item.sort :best, children
    
    children.each do |x|
      yield render(x), level
      
      render_tree x,  level + 1 do |result, level|
        yield result, level
      end
      
    end
  end
end
