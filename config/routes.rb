Rails.application.routes.draw do
  
  devise_for :users
  root to: 'items#index'
  
  resources :items, only: [:new, :create, :show, :edit, :update] do

  end

end