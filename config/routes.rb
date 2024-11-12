Rails.application.routes.draw do
  root "posts#index"
  devise_for :users
  resources :posts do
    member do
      patch :approve
      patch :reject
      patch :send_for_review
    end
  end
end
