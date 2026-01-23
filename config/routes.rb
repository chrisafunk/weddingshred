
# config/routes.rb
Rails.application.routes.draw do


  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root "dashboard#index"

  post 'set_current_group', to: 'application#set_current_group', as: :set_current_group

  namespace :admin do
    get '/', to: 'index'
    resources :users, only: [:index, :edit, :update, :new, :create, :destroy]
    resources :wedding_groups do
      member do
        get :add_member
        post :set_member
        post :remove_member
        post :create_member
        post :toggle_admin, to: 'wedding_groups#toggle_admin', as: :toggle_admin
      end
    end
  end


  # suppress Chrome DevTools "This site uses an app-specific manifest" warning
  get '/.well-known/appspecific/com.chrome.devtools.json', to: proc { [204, {}, ['']] }

  resource :profile, only: [:edit, :update]

  resources :exercises


end
