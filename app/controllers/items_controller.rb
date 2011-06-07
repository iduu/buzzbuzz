class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
end
