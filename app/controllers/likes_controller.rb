class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_likeable

  def create
    # Create a like for current_user on the likeable object
    @like = @likeable.likes.new(user: current_user)

    if @like.save
      redirect_back fallback_location: root_path, notice: "Liked!"
    else
      redirect_back fallback_location: root_path, alert: "Unable to like."
    end
  end

  def destroy
    # Find and destroy the like by current_user on the likeable
    @like = @likeable.likes.find_by(user: current_user)

    if @like&.destroy
      redirect_back fallback_location: root_path, notice: "Unliked!"
    else
      redirect_back fallback_location: root_path, alert: "Unable to unlike."
    end
  end

  private
    def set_likeable
      klass = params[:likeable_type].constantize
      puts klass
      @likeable = klass.find(params[:likeable_id])
    end
end
