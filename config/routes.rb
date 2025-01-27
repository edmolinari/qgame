Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  get :matches_report, to: 'pages#matches_report'
  get :raw_file, to: 'pages#raw_file'
  get :deaths_report, to: 'pages#deaths_report'
  get :ranking_report, to: 'pages#ranking_report'

  # Defines the root path route ("/")
  root to: 'pages#home'
end
