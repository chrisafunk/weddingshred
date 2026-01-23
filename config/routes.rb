
# config/routes.rb
Rails.application.routes.draw do


  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root "dashboard#index"

  namespace :admin do
    get '/', to: 'index'

    resources :users, only: [:index, :edit, :update, :new, :create]

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


  get "group_admin_dashboard", to: "group_admin_dashboard#index", as: :group_admin_dashboard

  get "group_admin_memberships", to: "group_admin_memberships#index", as: :group_admin_memberships
  post "group_admin_memberships/:id/join", to: "group_admin_memberships#join", as: :join_group_admin_membership
  post "group_admin_memberships/:id/unjoin", to: "group_admin_memberships#unjoin", as: :unjoin_group_admin_membership
  patch "group_admin_memberships/:id/update_role", to: "group_admin_memberships#update_role", as: :update_role_group_admin_membership



end
