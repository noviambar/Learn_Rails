class ProfilesController < ApplicationController
  def index
    @profiles = User.joins(:role)
    @profiles =  User.order(params[:sort])
    @roles = Role.order(params[:sort])
    @profile =  Social.joins(:user)
    unless @profiles.kind_of?(Array)
      @profiles = @profiles.page(params[:page]).per(3)
    else
      @profiles = Kaminari.paginate_array(@profiles).page(params[:page]).per(3)
    end
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
      flash.now[:messages] = @profile.errors.full_messages[0]
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
    
    if @profile.update!(profile_params)
      redirect_to profile_path, flash: { notice: 'Successfully Updated User' }
    else
      flash.now[:messages] = @profile.errors.full_messages[0]
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @social = Social.find_by(params[:user_id])
    @profile = User.find(params[:id])
    @profile.destroy
  
    redirect_to profiles_path, status: :see_other
  end

  private
  def profile_params
    params.require(:user).permit(:id, :name, :mobile, :email, :avatar,:password, :role_id, socials_attributes: [:id, :user_id, :name, :short, :_destroy])
  end
end
