Rails.application.routes.draw do
  # devise_for :users
  apipie
  get '/home', to: 'home#index', as: 'home'
  root to: redirect('/home')

  resources :avatar, only:[:edit, :update, :destroy]
  resources :users, only:[:edit, :update]
  # resources :books, only:[:new, :create, :show, :destroy]
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
  devise_scope :user do
    get '/student/sign_in', to: 'users/sessions#new'
    post '/student/sign_in', to: 'users/sessions#create', as: 'new_student_registration'
  end

  namespace :api do
    namespace :v1 do
      resources :users
    end
  end
  
  # resources :student, only: [:new, :create]
  # resources :tags, only: [:new, :create, :destroy]

  # get '/student_list', to: 'student#list', as: 'student_list'
  # get '/student/active', to: 'student#active', as: 'active'
  # put '/student/:id/suspend', to: 'student#suspend_student', as: 'suspend_student'
  # get '/student/suspended', to: 'student#suspended_student', as: 'suspended_student'
  # post '/student/:id/reactivation', to: 'student#send_reactivation_mail', as: 'send_reactivation_mail'
  # get '/student/:id/reactivate', to: 'student#reactivate_student', as: 'reactivate_student'
  # get '/book_list', to: 'books#list', as: 'book_list'
  # put '/book/:id/archive', to: 'books#archive', as: 'book_archive'
  # get '/tags_list', to: 'tags#list', as: 'tag_list'
  # post '/book/:id/issue', to: 'books#issue', as: 'book_issue'
  # put '/book/:id/like', to: 'books#like', as: 'book_like'
  # get '/book/issued_list', to: 'books#issued_list', as: 'issued_list'
  # put '/book/:id/return', to: 'books#return', as: 'return_book'
  # get 'book/:id/preview', to: 'books#preview', as: 'preview_book'

  resources :student, only: [:new, :create] do
    collection do
      get :student_list, action: :list, as: :student_list
      get :active, action: :active, as: :active
      get :suspended_student, action: :suspended_student, as: :suspended_student
    end
    
    member do
      put :suspend_student, as: :suspend_student
      post :send_reactivation_mail, as: :send_reactivation_mail
      get :reactivate_student, action: :reactivate_student, as: :reactivate_student
    end
  end
  
  resources :books, only: [:new, :create, :show, :destroy] do
    collection do
      get :book_list, action: :list, as: :book_list
      get :issued_list, action: :issued_list, as: :issued_list
    end
  
    member do
      put :archive, as: :archive, as: :book_archive
      post :issue, as: :issue, as: :book_issue
      put :like, as: :like, as: :book_like
      put :return, as: :return, as: :return_book
      get :preview, as: :preview, as: :preview_book
    end
  end
  
  resources :tags, only: [:new, :create, :destroy] do
    collection do
      get :tag_list, action: :list, as: :tag_list
    end
  end
  
  
  
  
end
