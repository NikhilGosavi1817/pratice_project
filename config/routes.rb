Rails.application.routes.draw do
  # devise_for :users
  get '/home', to: 'home#index', as: 'home'
  root to: redirect('/home')

  resources :avatar, only:[:edit, :update, :destroy]
  resources :users, only:[:edit, :update]
  resources :books, only:[:new, :create, :show, :destroy]
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
  devise_scope :user do
    get '/student/sign_in', to: 'users/sessions#new'
    post '/student/sign_in', to: 'users/sessions#create', as: 'new_student_registration'
  end

  resources :student, only: [:new, :create]
  get '/student_list', to: 'student#list', as: 'student_list'
  get '/student/active', to: 'student#active', as: 'active'
  put '/student/:id/suspend', to: 'student#suspend_student', as: 'suspend_student'
  get '/student/suspended', to: 'student#suspended_student', as: 'suspended_student'
  post '/student/:id/reactivation', to: 'student#send_reactivation_mail', as: 'send_reactivation_mail'
  get '/student/:id/reactivate', to: 'student#reactivate_student', as: 'reactivate_student'
  get '/book_list', to: 'books#list', as: 'book_list'
  put '/book/:id/archive', to: 'books#archive', as: 'book_archive'
  resources :tags, only: [:new, :create, :destroy]
  get '/tags_list', to: 'tags#list', as: 'tag_list'
  post '/book/:id/issue', to: 'books#issue', as: 'book_issue'
  put '/book/:id/like', to: 'books#like', as: 'book_like'
  get '/book/issued_list', to: 'books#issued_list', as: 'issued_list'
  put '/book/:id/return', to: 'books#return', as: 'return_book'
  get 'book/:id/preview', to: 'books#preview', as: 'preview_book'
end
