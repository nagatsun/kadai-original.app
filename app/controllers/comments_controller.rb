  class CommentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    #@remsg = Comment.new(remsg_params)
    @tecpost = Tecpost.find(params[:tecpost_id])
    @remsgs = @tecpost.comments
    @remsg = current_user.comments.build(remsg_params)
    @remsg.tecpost_id = @tecpost.id
    @remsg.user_id = current_user.id
    if @remsg.save
      flash[:success] = "コメントしました"
      redirect_back(fallback_location: root_path)
    else
      @remsgs = Comment.order(id: :desc).page(params[:page]).per(3)
      flash[:success] = "コメントできませんでした"
      #redirect_back(fallback_location: root_path)
      render 'tecposts/show'
    end
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    flash[:success] = 'コメントを削除しました。'
    redirect_back(fallback_location: root_path)
  end


  
  private
  def remsg_params
    params.require(:comment).permit(:content, :user_id, :tecpost_id, :image)
  end
  
  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    unless @comment
      redirect_to root_url
    end
  end
end    