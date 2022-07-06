class ProfilesController < ApplicationController
  def index
    @profiles = User.joins(:role)
    @profile =  Social.joins(:user)
    @paginates = @profiles.page(params[:page])
    # @profiles = Kaminari.paginate_array(User.first(5)).page(params[:page])
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
    # @profile = User.find(params[:id])
    @profile = User.joins(:role).find(params[:id])
  end

  def edit
    @profile = User.find(params[:id])
    @roles = Role.pluck(:name, :id)
  end

  def update
    @profile = User.find(params[:id])
    
    if @profile.update(profile_params)
      redirect_to profile_path, flash: { notice: 'Successfully Updated User' }
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @profile = User.find(params[:id])
    @profile.destroy
  
    redirect_to profiles_path, status: :see_other
  end

  private
  def profile_params
    params.require(:user).permit(:id, :name, :mobile, :email, :password, :role_id, socials_attributes: [:id, :name, :short, :_destroy])
  end
end
