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

  def create_profile
    @user = current_user

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to root_path, notice: "User Profile was successfully created." }
        format.json { render :profile, status: :created, location: @user }
      else
        format.html { render :new_profile, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :name, :profile_picture)
    end
end
