Rails.application.routes.draw do

  devise_for :users

  resources :nodes, path: 'files', only: [:show, :index, :create, :new] do
    collection do
      post :upload
    end
  end

  root to: 'home#index'

  resources :questions, except: [:new]

  resources :questionnaires do
    resources :questions, only: [:new]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
