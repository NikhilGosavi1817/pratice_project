class AvatarController < ApplicationController
    def edit
    end

    def update
        if params[:user].present? && params[:user][:avatar].present?
            current_user.avatar.attach(params[:user][:avatar])
            if current_user.avatar.attached? && current_user.valid?
                redirect_to edit_avatar_path
            # else
            #     flash[:alert]= current_user.errors.full_messages
            #     redirect_to edit_avatar_path
            end
            # flash[:alert]="Choose a file"
            # redirect_to edit_avatar_path
        end
    end

    def destroy
        current_user.avatar.purge
        redirect_to edit_avatar_path
    end
end
