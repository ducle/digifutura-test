Rails.application.routes.draw do

  devise_for :users

  resources :nodes, path: 'files', only: [:show, :index, :create, :new] do
    collection do
      post :upload
    end
    member do
      get :sharing
      post :share
      post :tagging
    end
  end

  resources :sharings, only: [:show, :index]

  resources :questions, except: [:new]

  resources :questionnaires do
    get :sharing, :alert_answered, on: :member
    post :share, on: :member
    resources :questions, only: [:new]
  end

  get '/labels', to: 'home#labels'
  get 'quizzes', to: 'quizzes#index'
  get 'quizzes/take/:questionnaire_id', to: 'quizzes#take', as: :take_quizzes
  get 'quizzes/result/:questionnaire_id', to: 'quizzes#result', as: :result_quizzes
  post 'quizzes/answer/:questionnaire_id', to: 'quizzes#answer', as: :answer_quizzes

  root to: 'nodes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
