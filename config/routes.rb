
# config/routes.rb
Rails.application.routes.draw do
  get "leaderboard/index"
  devise_for :users

  namespace :admin do
    get "month_plan_leaderboards/show"
    resources :exercises


    resources :month_plans do
      member { get :duplicate } # optional from earlier UX niceties
    end

    get :leaderboard # /admin/month_plans/:id/leaderboard

  end


  get "ui/smoke", to: "ui#smoke"


  resources :workout_entries


  # Leaderboard with tabbed views: ?view=monthly or ?view=all_time
  get "leaderboard", to: "leaderboard#index"


  root "dashboard#index"


  resources :month_plans, only: [] do
    member do
      get :exercises, to: "month_plans#exercises"
    end
  end


end
