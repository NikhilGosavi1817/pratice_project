class StudentMailer < ApplicationMailer
    def registration_mail
        @student=params[:user]
        mail(to: @student.email, subject: "Welcome to library")
    end

    def reactivation_mail
        @student=params[:user]
        mail(to: @student.email, subject: "Reactivation mail")
    end
end
