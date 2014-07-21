module SessionsHelper

  #TODO: REFACTOR THIS SOMEWHERE ELSE AND REMOVE THIS ENTIRE FILE
  def current_user?(user)
    user == current_user
  end
  
  #All the below code was rendered obsolete by Devise
  
  # def sign_in(user, update_login=false)   
  #     if update_login
  #       session[:prior_login] = user.last_login
  #       user.update_attribute(:last_login, Time.now)
  #     end
  #     cookies.permanent[:remember_token] = user.remember_token
  #     self.current_user = user
  #     
  #   end
  #   
  #   def signed_in?
  #     !current_user.nil?
  #   end
  #   
  #   def current_user=(user)
  #     @current_user = user
  #   end
  #   
  #   def current_user
  #     @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  #   end
  #
  #   
  #   def signed_in_user
  #     unless signed_in?
  #       store_location
  #       redirect_to signin_path, notice: "Please sign in"
  #     end
  #   end  
  #   
  #   def sign_out
  #     self.current_user = nil
  #   cookies.delete(:remember_token)
  #   end
  #   
  #   def redirect_back_or(default)
  #     redirect_to(session[:return_to] || default)
  #   session.delete(:return_to)
  #   end
  #   
  #   def store_location
  #     session[:return_to] = request.fullpath
  #   end
end
