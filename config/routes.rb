Leverage::Application.routes.draw do

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"

  devise_for :users, controllers: {
    confirmations: 'confirmations',
    omniauth_callbacks: 'omniauth_callbacks'
  }
  devise_scope :user do
    put "/confirm" => "confirmations#confirm"
  end

  get "/campaigns", to: "campaigns#catalog"
  post "/enrollments/:id/authorization", to: "enrollments#authorize", as: "enrollment_authorization"

  resources :users do
    resources :campaigns, shallow: true do
      resources :enrollments, only: [:create, :destroy]
      get :joined_users, as: 'recruits', on: :member
    end
    get :joined_campaigns, as: 'recruitments', on: :member
  end

  resources :messages
  resources :conversations

end
