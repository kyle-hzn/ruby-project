Rails.application.routes.draw do
  get 'errors/not_found'

  get 'errors/internal_server_error'

  devise_for :admins
  mount Ckeditor::Engine => '/ckeditor'
  root to: "posts#index"

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
  
  resources :posts do
    resources :comments
  end
end
