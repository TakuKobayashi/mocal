Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  namespace :api, format: false, defaults: { format: :json } do
    resource :top, only: [] do
      #get :asahi
      #get :company_detail
      #get :social
      get 'asahi', to: "top#asahi"
      get 'company_detail', to: "top#company_detail"
      get 'social', to: "top#social"
    end

    resource :environment, controller: :environment do
      get :ulterviolet
    end
    resources :music_scores

    resource :face_recognition, controller: :face_recognition do
      post 'recognize'
      post 'tag'
    end

    resources :sound, only: [] do
      collection do
        post 'upload'
      end
    end
  end

  resource :json_converter, controller: :json_converter, only: [] do
    get  :index
    post :convert
  end

  resource :top, controller: :top, only: [:index] do
    get 'debug'
  end

  resource :inspection, controller: :inspection do
    get 'face_recognize'
    get 'draw'
    get 'audio'
  end

  root to: "top#index"
end
