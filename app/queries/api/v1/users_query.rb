module Api
    module V1
        class UsersQuery

            def initialize(params)
                @params=params
            end

            def call
                @user=User.all
                @user=@user.where(first_name: @params[:first_name]) if @params[:first_name].present?
                @user=@user.where(last_name: @params[:last_name]) if @params[:last_name].present?
                @user=@user.where(email: @params[:email]) if @params[:email].present?
                @user
            end
        end
    end
end