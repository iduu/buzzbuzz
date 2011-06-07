class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  
  def vote
    @item = Item.find(params[:item_id])
    Vote.make(current_user, @item, params[:score].to_i)
    redirect_to :back
  end
end
