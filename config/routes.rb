Rails.application.routes.draw do
  devise_for :members

  unauthenticated do
    as :member do
      root to: 'devise/sessions#new'
    end
  end

  # root to dashboard later
  root to: 'main_pages#home'

  resources :projects do
    resources :tasks
  end
end
