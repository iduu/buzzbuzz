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
    @item = Item.find(params[:item_id])
    begin
      Vote.make(current_user, @item, params[:score].to_i)
    rescue
      # TODO
    end
    respond_to do |format|
      format.html { redirect_to item_path(@item), :notice => "vote success" }
      format.js
    end
  end
end
