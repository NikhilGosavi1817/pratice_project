class CreateUser < ActiveInteraction::Base
    string :first_name
    string :last_name
    integer :age
    string :date_of_birth
    string :email
    string :password

    def execute
        @user=User.create(inputs)
        if @user.errors.any?
            return @user.errors
        else
            return @user
        end
    end
end