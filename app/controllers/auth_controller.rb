class AuthController < ApplicationController

  def index
    @users = User.all
    @user = User.new
  end

  # def user
  #   @user = User.new(user_params)

  #   respond_to do |format|
  #     if @user.save
  #       # @users = User.all
  #       format.turbo_stream
  #       format.html {redirect_to auth_path(@user), notice: 'Article successfuly created'}
        
  #       # format.html {redirect_to root_path(@article), notice: 'Article successfuly created'}
  #       # format.js       
  #       # redirect_to @article
  #     else
  #       format.html{ render action: "new", status: :unprocessable_entity}
  #       # render :new, status: :unprocessable_entity
  #     end
  #   end
  # end

  #create form edit user
  def edit
    @user = User.find(params[:id])
  end
  
  #update user
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      redirect_to @user, flash: { notice: 'Successfully Updated User' }
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def form_register
    @user = User.new
    @users = Role.pluck(:name, :id)
    @user.roles.build
  end

  def form_user
    @user = User.new
    @user.roles.build
  end

  def register
    @user = User.new(user_params)

    if @user.save
      @user.roles.create
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
    params.require(:user).permit(:id, :name, :phone, :email, :password, roles_attributes: [:id, :name, :user_id])
  end
end
