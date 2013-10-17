Sample::Application.routes.draw do

  devise_for :users

  resources :hotels, only: [:new, :index, :show, :create] do
    resources :comments, :rates, only: :create
  end

  root :to => 'hotels#index'

end
