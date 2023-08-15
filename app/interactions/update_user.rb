class UpdateUser < ActiveInteraction::Base
    object :user
    string :first_name, default: nil
    string :last_name, default: nil
    integer :age, default: nil
    string :date_of_birth, default: nil
    string :email, default: nil
    string :password, default: nil

    def execute
        @user.update(inputs.except(:user).compact)
        if @user.errors.any?
            return @user.errors
        else
            return @user
        end
    end
end