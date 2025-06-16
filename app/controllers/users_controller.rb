class UsersController < ApplicationController
  def all
    @users = User.all
  end

  def profile
    @user = User.find(params[:id])
  end

  def new_profile
    @user = current_user
  end

  private
    def user_params
      params.require(:users).permit(:username, :name, :profile_picture)
    end
end
