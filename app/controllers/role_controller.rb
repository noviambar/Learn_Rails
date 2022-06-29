class RoleController < ApplicationController

  def form_role
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)

    if @role.save
      redirect_to form_role_path, flash: { notice: "Role successfuly added"}
    else
      flash.now[:messages] = @user.errors.full_messages[0]
      render :form_role
    end
  end

  private
  def role_params
    params.require(:role).permit(:name, :status)
  end
end
