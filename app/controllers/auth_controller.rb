class AuthController < ApplicationController

  def index
    @users = User.joins(:role)
  end

  def new
    @user = new
  end

  def create
    @user = new(user_params)

    if @user.save
      redirect_to auth_path, flash: { notice: "Successfully created account"}
    else
      flash.now[:messages] = @user.errors.full_messages[0]
      render :new
    end
  end

  def form_register
    @user = User.new
    @users = Role.pluck(:name, :id)
  end

  def register
    @user = User.new(user_params)
    
    if @user.save
      redirect_to form_login_path, flash: { notice: "Successfully created account"}
    else
      flash.now[:messages] = @user.errors.full_messages[0]
      render :form_register
    end
  end

  def form_login
  end

  def login
    email = params[:email]
    password = params[:password]
    
    user = User.find_by(email: email)
    if user
      if user.authenticate(password)
        # membuat session dengan key = :user_id
        session[:user_id] = user.id
        redirect_to articles_path, flash: { notice: "Welcome #{user.name}" }
      else
        redirect_to form_login_path, flash: {alert: "Email or Password Incorrect!"}
      end
    else
      redirect_to form_login_path, flash: {alert: "Email or Password Incorrect!"}
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to form_login_path, flash: { notice: "Logout Successfully"}
  end

  private
  def user_params
    params.require(:user).permit(:name, :phone, :email, :role_id, :password)
  end
end
