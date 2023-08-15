class StudentController < ApplicationController
    # before_action :set_student, only: []

    def list
        @student = User.where(:role_type=>1)

        if params[:filter]=="active"
            @student=@student.where(:status=>1)
        elsif params[:filter]=="suspended"
            @student=@student.where(:status=>2)
        end

        if params[:sort].present?
            sort_column=params[:sort] || "id"
            sort_direction = %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
            # sort_direction= params[:direction] || "desc"
            @student=@student.order(Arel.sql("#{sort_column} #{sort_direction}"))
        end
        @student=@student.paginate(page: params[:page], per_page: 10)
    end

    def new
        @student=User.new
    end

    def create
        @student=User.new(student_params)
        @student.password=SecureRandom.alphanumeric(8)
        
        if @student.save
            StudentMailer.with(user: @student).registration_mail.deliver_now
            redirect_to root_path, notice: "Student #{@student.first_name} is registered to the library successfully"
        else
            render :new
        end
    end

    def student_params
        params.require(:user).permit(:first_name, :last_name, :age, :date_of_birth, :email)
    end

    def active
        @student = User.where(:role_type=>1)
        @student=@student.where(:status=>1)
        if params[:sort].present?
            sort_column=params[:sort]
            sort_direction=params[:direction] || "desc"
            @student=@student.order("#{sort_column} #{sort_direction}")
        end
        @student=@student.paginate(page: params[:page], per_page: 10)
    end

    def suspend_student
        @student=User.find(params[:id])
        if @student.suspend!
            redirect_to active_student_index_path , notice:"Student suspended successfully!"
        else
            redirect_to active_student_index_path , notice:"Student not suspended"
        end
    end

    def suspended_student
        @student = User.where(:role_type=>1)
        @student=@student.where(:status=>2)
        # sort_column = params[:sort] || "id"
        # @student = @student.where(status: "suspended").order(sort_column).paginate(page: params[:page], per_page: 10)
        if params[:sort].present?
            sort_column=params[:sort]
            sort_direction=params[:direction] || "desc"
            @student=@student.order("#{sort_column} #{sort_direction}")
        end
        @student=@student.paginate(page: params[:page], per_page: 10)
    end

    def send_reactivation_mail
        @student=User.find(params[:id])
        StudentMailer.with(user: @student).reactivation_mail.deliver_now
        redirect_to suspended_student_student_index_path, notice: "Reactivation mail sent"
    end

    def reactivate_student
        @student=User.find(params[:id])
        if @student.reactivate!
            redirect_to root_path, notice: "Now you can login"
        end
    end
end
