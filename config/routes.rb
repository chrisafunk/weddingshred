
# config/routes.rb
Rails.application.routes.draw do


  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root "dashboard#index"

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


  resources :workout_entries


  # Leaderboard with tabbed views: ?view=monthly or ?view=all_time
  get "leaderboard", to: "leaderboard#index"


  resources :month_plans, only: [] do
    member do
      get :exercises, to: "month_plans#exercises"
    end
  end

  # suppress Chrome DevTools "This site uses an app-specific manifest" warning
  get '/.well-known/appspecific/com.chrome.devtools.json', to: proc { [204, {}, ['']] }

  resource :profile, only: [:edit, :update]




end
