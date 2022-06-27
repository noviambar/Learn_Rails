class ApplicationController < ActionController::Base

  layout 'dashboard'

  helper_method :user_signed_in?
  helper_method :current_user

  #mencari user berdasarkan session key
  def current_user
    if session[:user_id]
        User.find(session[:user_id])
    else
        nil
    end
  end

  #mengecek apakah user sudah login
  def user_signed_in?
    if current_user
      true
    else
      redirect_to form_login_path, flash: { alert: "Please Login!" }
      return false
    end
  end
end
