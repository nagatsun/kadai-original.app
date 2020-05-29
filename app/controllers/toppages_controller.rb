class ToppagesController < ApplicationController
  def index
    if logged_in?
      @tecpost = current_user.tecposts.build  # form_with 用
      @tecposts = current_user.feed_tecposts.order(id: :desc).page(params[:page]).per(5)
    end
  end
end