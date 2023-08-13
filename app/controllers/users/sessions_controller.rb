# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    if current_user.present?
      if request.path=="/users/sign_in"
        if current_user.librarian?
          super
        else
          sign_out current_user
          redirect_to root_path, notice: "Unauthorized access"
        end
      elsif request.path=="/student/sign_in"
        if current_user.student?
          if current_user.suspended?
            sign_out current_user
            redirect_to root_path, notice: "Suspended"
          else
            super
          end
        else
          sign_out current_user
          redirect_to root_path, notice: "Unauthorized access"
        end
      end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
