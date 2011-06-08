class ItemsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  
  def show
    @item = Item.find(params[:id])
    @comment = Comment.new
    respond_to do |format|
      format.html
    end
  end
  
  def vote
    score = params[:score].to_i
    @item = Item.find(params[:item_id])
    @notice = "vote #{score} success!"
    
    @vote = Vote.make(current_user, @item, score)
    
    respond_to do |format|
      format.js
    end
  end
end
