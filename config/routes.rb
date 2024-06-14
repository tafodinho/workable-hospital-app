Rails.application.routes.draw do
  
  devise_for :users, path_names: { sign_up: 'register_not_allowed' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  authenticate :user do 
    resources :patients
    resources :doctors
    resources :users
    get "/dashboard", :to => "dashboards#index"
    post "/dashboard", :to => "dashboards#index"
    root to: "patients#index"
  end
  # Defines the root path route ("/")
  # root "articles#index"
  
end
