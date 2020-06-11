class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    tecpost = Tecpost.find(params[:tecpost_id])
    current_user.like(tecpost)
    flash[:success] = 'お気に入りに登録しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    tecpost = Tecpost.find(params[:tecpost_id])
    current_user.unlike(tecpost)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
