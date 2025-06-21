class UsersController < ApplicationController
  before_action :set_user, only: %i[ profile edit_profile ]
  before_action :authenticate_user!, only: %i[ new_profile edit_profile update_profile ]

  def index
    @users = User.all
  end

  def profile
    @posts = @user.posts
  end

  def new_profile
    if has_profile?
      flash[:notice] = "You already have a profile"
      redirect_to "/users/#{current_user.id}/profile/edit"
    else
      @user = current_user
    end
  end

  def edit_profile
  end

  def update_profile
    @user = current_user

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to root_path, notice: "User profile was successfully #{has_profile? ? "updated" : "created"}." }
        format.json { render :profile, status: has_profile? ? :ok : :created, location: @user }
      else
        format.html { render :new_profile, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def has_profile?
      # I'll consider having a username as the bare minimum of a profile
      !current_user.username.blank?
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def user_params
      params.require(:user).permit(:username, :name, :profile_picture)
    end
end
