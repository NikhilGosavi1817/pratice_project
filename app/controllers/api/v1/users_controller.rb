class Api::V1::UsersController < ApplicationController
    before_action :authenticate_admin!
    skip_before_action :verify_authenticity_token
    before_action :find_id, only: [:show, :update, :destroy]
    # api :GET, '/api/v1/users', 'Get a list of all users'
    api :GET, '/api/v1/users', 'Get a list of users with the filter'
      param :first_name, String, desc: 'Filter users by first name'
      param :last_name, String, desc: 'Filter users by last name'
      param :email, String, desc: 'Filter users by email'
    def index
        # @user=User.all
        @user=Api::V1::UsersQuery.new(params).call
        render json: @user
    end

    api :POST, '/api/v1/users', 'Create a new user'
        param :first_name, String, desc: 'First Name', required: true
        param :last_name, String, desc: 'Last Name', required: true
        param :age, Integer, desc: 'Age', required: true
        param :date_of_birth, Date, desc: 'Date of birth', required: true
        param :email, String, desc: 'Email', required: true
        param :password, String, desc: 'Password', required: true
    def create
        @user=CreateUser.run(params)
        if @user.valid?
            render json: @user.result, status: :created
        else
            render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
        end
    end

    api :GET, '/api/v1/users/:id', 'Show a user'
        param :id, String, desc: 'ID', required: true
    def show
        render json: @user, status: :ok
    end

    api :PUT, '/api/v1/users/:id', 'Update user'
        param :id, String, desc: 'ID', required: true
        param :first_name, String, desc: 'First Name', required: false
        param :last_name, String, desc: 'Last Name', required: false
        param :age, Integer, desc: 'Age', required: false
        param :date_of_birth, Date, desc: 'Date of birth', required: false
        param :email, String, desc: 'Email', required: false
        param :password, String, desc: 'Password', required: false
    def update
        @user=UpdateUser.run(params.merge(user: @user))
        # binding.pry
        if @user.valid?
            render json: @user.result, status: :ok
        else
            render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def find_id
        @user=User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: {error: 'User not found'}, status: :not_found
    end

    api :DELETE, '/api/v1/users/:id', 'Deletes a user'
        param :id, String, desc: 'ID', required: true
    def destroy
        @user.destroy
        render json: {error: 'User deleted successfully'}, status: :ok
    end

end
