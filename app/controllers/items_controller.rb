class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @level = 0
    respond_to do |format|
      format.html
    end
  end
end
