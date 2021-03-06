Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout',                  to: 'sessions#destroy'
  get '/auth/failure',            to: redirect('/')

  resources :users do
    get '/review_for/:date(/:old_date)', to: 'items#review', as: :review
    get '/monthly_review_for/:month(/:old_month)', to: 'items#monthly_review', as: :monthly_review
    get '/accounts(/:month)', to: 'accounts#index', as: :accounts

    resources :accounts do
      resources :items
    end
  end

  root 'welcome#index'
end
