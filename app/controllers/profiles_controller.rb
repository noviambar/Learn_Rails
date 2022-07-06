class ProfilesController < ApplicationController
  def index
    @profiles = User.joins(:role)
    @profile =  Social.find_by(params[:id])
  end

  def new
    @profile = User.new
    @roles = Role.pluck(:name, :id)
    @profile.socials.build
  end

  def create
    @profile = User.new(profile_params)

    if @profile.save
      redirect_to profiles_path, flash: { notice: "User successfuly added"}
    else
      render :new
    end
  end

  def show
    @profile = User.find(params[:id])
  end

  private
  def profile_params
    params.require(:user).permit(:id, :name, :mobile, :email, :password, :role_id, socials_attributes: [:id, :name, :short])
  end
end
