class AuthController < ApplicationController
  def form_register
    @user = User.new
  end

  def register
    @user = User.new(user_params)
    if @user.save
      redirect_to form_login_path, notice: "Successfully created account"
    else
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
        redirect_to articles_path, notice: "Welcome #{user.name}"
      else
        redirect_to form_login_path, alert: "Email or Password Incorrect"
      end
    else
      redirect_to form_login_path, alert: "Email or Password Incorrect!"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to form_login_path, notice: "Logout Succesfully"
  end

  private
  def user_params
    params.require(:user).permit(:name, :phone, :email, :position, :password)
  end
end
