Leverage::Application.routes.draw do

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"

  devise_for :users, :controllers => {:confirmations => 'confirmations'}
  devise_scope :user do
    put "/confirm" => "confirmations#confirm"
  end

  resources :users do
    resources :campaigns do
      resources :enrollments, only: [:create, :destroy]
      get :joined_users, as: 'enrollment', on: :member
    end
    get :joined_campaigns, as: 'enrollment', on: :member
  end

end
