class TecpostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  
  def edit
  end

  def create
    
    @tecpost = current_user.tecposts.build(tecpost_params)
    if @tecpost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @tecposts = current_user.feed_tecposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @tecpost.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def tecpost_params
    params.require(:tecpost).permit(:title, :content, :image)
  end
  
  def correct_user
    @tecpost = current_user.tecposts.find_by(id: params[:id])
    unless @tecpost
      redirect_to root_url
    end
  end
end