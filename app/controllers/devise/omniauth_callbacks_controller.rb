class Devise::OmniauthCallbacksController < DeviseController
  prepend_before_filter { request.env["devise.skip_timeout"] = true }

  def passthru
    render :status => 404, :text => "Not found. Authentication passthru."
  end

  def failure
    set_flash_message :alert, :failure, :kind => failed_strategy.name.to_s.humanize, :reason => failure_message
    redirect_to after_omniauth_failure_path_for(resource_name)
  end
  
  def facebook
    #raise request.env["omniauth.auth"].to_yaml
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      if @user.sign_in_count == 0
        sign_in @user
        redirect_to edit_user_registration_path(@user)
      else
        sign_in_and_redirect @user, :event => :authentication
      end
      
      session['fb_access_token'] = request.env["omniauth.auth"].credentials.token
      
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      ##redirect_to new_user_registration_url
      redirect_to root_path
    end
  end
  

  protected

  def failed_strategy
    env["omniauth.error.strategy"]
  end

  def failure_message
    exception = env["omniauth.error"]
    error   = exception.error_reason if exception.respond_to?(:error_reason)
    error ||= exception.error        if exception.respond_to?(:error)
    error ||= env["omniauth.error.type"].to_s
    error.to_s.humanize if error
  end

  def after_omniauth_failure_path_for(scope)
    new_session_path(scope)
  end
 
end
