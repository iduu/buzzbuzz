class RootController < ApplicationController
  before_filter :authenticate_user!
  
  def best
    @topics = Topic.content_for :best, :page => params[:page].to_i, :per_page => 15
    @type = 'best'
    respond_to do |format|
      format.html { render 'index' }
      format.js { render 'index' }
    end
  end
  
  def worst
    @topics = Topic.content_for :worst, :page => params[:page].to_i, :per_page => 15
    @type = 'worst'
    respond_to do |format|
      format.html { render 'index' }
      format.js { render 'index' }
    end
  end
  
  def recent
    @type = 'recent'
    @topics = Topic.content_for :recent, :page => params[:page].to_i, :per_page => 15
    respond_to do |format|
      format.html { render 'index' }
      format.js { render 'index' }
    end
  end
end
