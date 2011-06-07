class RootController < ApplicationController
  def index
    @best = Topic.content_for :best
  end
end
