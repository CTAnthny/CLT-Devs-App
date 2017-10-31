Rails.application.routes.draw do
  devise_for :members
  root 'main_pages#home'
end
