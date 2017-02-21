Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    resources :customers, only: [:show] do
      get :orders, on: :member
    end
    resources :products, only: [:index] do
			get :products, on: :collection
		end
  end

end
