Rails.application.routes.draw do

  devise_for :users
  devise_scope :user do
    get '/login' => 'devise/sessions#new'
    get '/logout' => 'devise/sessions#destroy'
  end

  resources :user, :controller => "user"
  
  root 'welcome#index'

  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox

  get "adminpanel" => "panel#main"

  resources :conversations do
    member do
      post :reply
    end
  end
  
end
