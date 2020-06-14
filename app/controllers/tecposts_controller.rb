class TecpostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit,:update,:destroy]
  
  def show
    @tecpost = Tecpost.find(params[:id])
    @remsgs = @tecpost.comments.order(id: :desc).page(params[:page]).per(3)
    #@remsg = Comment.new
    @remsg = current_user.comments.build
    @remsg.tecpost_id = params[:id]
  end
  
  def edit
    @tecpost = Tecpost.find(params[:id])
  end
  
  def update
    @tecpost = Tecpost.find(params[:id])

    if @tecpost.update(tecpost_params)
      flash[:success] = 'メッセージを編集しました'
      redirect_to @tecpost
    else
      flash.now[:danger] = 'メッセージの編集は失敗しました'
      render :edit
    end
  end
  
  def create
    @tecpost = current_user.tecposts.build(tecpost_params)
    if @tecpost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @tecposts = current_user.feed_tecposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿は失敗しました。'
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