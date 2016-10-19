Rails.application.routes.draw do

  devise_for :users

  resources :nodes, path: 'files', only: [:show, :index, :create, :new] do
    collection do
      post :upload
    end
    member do
      get :sharing
      post :share
    end
  end

  resources :sharings, only: [:show, :index]

  resources :questions, except: [:new]

  resources :questionnaires do
    get :sharing, on: :member
    post :share, on: :member
    resources :questions, only: [:new]
  end

  get 'quizzes', to: 'quizzes#index'
  get 'quizzes/:questionnaire_id/take', to: 'quizzes#take'

  root to: 'nodes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
