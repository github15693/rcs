Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    # The priority is based upon order of creation: first created -> highest priority.
    # See how all your routes lay out with "rake routes".

    # You can have the root of your site routed with "root"
    root 'welcomes#index'

    # Example of regular route:
    #   get 'products/:id' => 'catalog#view'

    # Example of named route that can be invoked with purchase_url(id: product.id)
    #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

    # Example resource route (maps HTTP verbs to controller actions automatically):
    #   resources :products
    resources :welcomes, only: [:index, :create]
    resource :session, only: [:create, :destroy]
    resources :features, only: [:index]
    resources :residents, only: [:index]
    resources :merchants, only: [:index, :create]
    resources :media, only: [:index]
    resources :contacts, only: [:index, :create]
    resource :user, only: [:show, :edit, :update] do
      member do
        get 'password'
        patch 'update_password'
        put 'update_password'
      end
    end
    resource :help, only: [] do
      member do
        get 'support'
        get 'about'
      end
    end

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

    resources :events do

    end
    resources :homes, only: [:index]

    resources :privileges, only: [:index, :show] do
      collection do
        post 'redeem_previlege'
      end
    end

    resources :courses, only: [:index, :show]

    get 'bookings/check_booking' => 'bookings#check_booking'
    post 'bookings/make_a_booking' => 'bookings#make_a_booking'
    resources :bookings do
    end


    resources :guard_houses do
      collection do

      end
    end
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
  end
end

