class UsersController < ApplicationController
    def edit
    end

    def update
        if current_user.update(user_params)
            redirect_to edit_user_path, notice: "user updated successfully"
        else
            render :edit
        end
    end

    def user_params
        params.require(:user).permit(:first_name, :last_name, :age, :date_of_birth, :email)
    end
end
