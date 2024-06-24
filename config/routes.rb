Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "main#index"

  resources :states
  resources :boards
  resources :tasks

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :tasks do
    collection do
      post 'simple_ajax'
      post 'move'
    end
  end
  resources :boards do
    resources :states do
      resources :tasks, only: [:new, :create, :edit, :update, :destroy]
    end
  end

  devise_scope :user do
    get '/users/sign_out', to: 'users/sessions#destroy_with_get', as: :destroy_user_session_get
  end

end
