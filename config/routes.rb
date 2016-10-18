Rails.application.routes.draw do

  devise_for :users

  resources :nodes, path: 'files', only: [:show, :index, :create] do
    
  end

  root to: 'home#index'

  resources :questionnaires

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
