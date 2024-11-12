Rails.application.routes.draw do
  root "posts#index"
  devise_for :users
  resources :posts do
    member do
      patch :approve
      patch :reject
      patch :send_for_review
    end
    collection do
      get :export
    end
  end
  resources :users, only: [:index, :edit, :update, :destroy] do
    member do
      patch :make_admin
    end
  end
end
