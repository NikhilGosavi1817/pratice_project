class ApplicationController < ActionController::Base
  before_action :configure_sign_up_params, if: :devise_controller?

    protected
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :age, :date_of_birth])
  end

  def authenticate_admin!
    header=request.headers['Authorization']
    if header.present?
      token=Token.find_by(value: header.split())
      if !token || token.expired_at<Time.now
        render json: {error: 'Unauthorized request'}, status: :unauthorized
      end
    end
  end


end
