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
    resources :campaigns
  end
end
