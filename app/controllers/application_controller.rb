class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :configure_account_update_params, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:image])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name,:image])
  end

  
	# def after_sign_in_path_for(resource)
 #    	user_path(current_user)
	# end

  def after_sign_in_path_for(user)
    
    origin_path = session[:origin_path]
    clear_origin_path
    if origin_path.present?
      origin_path
    else
      params[:target].presence || user_path(current_user)
    end
  end

  private

  def authenticate_user!
    
    store_origin_path
    super
  end

  def store_origin_path
    session[:origin_path] = request.fullpath
  end

  def clear_origin_path
    session[:origin_path] = nil
  end
end
