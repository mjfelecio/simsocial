class HomeController < ApplicationController
  def index
    if user_signed_in?
      # Posts from current user and people they follow
      following_ids = current_user.following.pluck(:id)
      @posts = Post.where(user_id: [ current_user.id ] + following_ids)
                  .includes(:user, :comments, :likes)
                  .order(created_at: :desc)
    else
      @posts = Post.all
    end
  end
end
