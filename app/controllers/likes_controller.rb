class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_likeable

  def create
    # Create a like for current_user on the likeable object
    @like = @likeable.likes.find_by(user: current_user)

    if @like
      @like&.destroy
      redirect_back fallback_location: root_path, notice: "Unliked"
    else
      @likeable.likes.create(user: current_user)
      redirect_back fallback_location: root_path, notice: "Liked"
    end
  end

  private
    def set_likeable
      klass = params[:likeable_type].constantize
      @likeable = klass.find(params[:likeable_id])
    end
end
