class ProfilesController < ApplicationController
  def show
    @profiles = User.joins(:role)
  end

  def new
    @profile = User.new
    @roles = Role.pluck(:name, :id)
  end

  def create
    @profile = User.new(profile_params)

    if @profile.save
      redirect_to profiles_path, flash: { notice: "User successfuly added"}
    else
      render :new
    end
  end

  private
  def profile_params
    params.require(:user).permit(:name, :mobile, :email, :password, :role_id)
  end
end
