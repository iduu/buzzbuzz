module CommentsHelper
  def vote_status(item, clazz)
    if !user_signed_in?
      return clazz
    end
    
    vote = Vote.find_by_user_item(current_user, item)
    
    if vote == nil
      return clazz
    end
    
    if vote.vote == 1 && clazz == :btn_up
      return [:btn_up, :btn_up_selected]
    elsif vote.vote == -1 && clazz == :btn_down
      return [:btn_down, :btn_down_selected]
    end
    
    clazz
  end
end
