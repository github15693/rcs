Rails.application.routes.draw do
  scope "(:locale)", locale: /vi|en/ do
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
    resources :bulletins, only: [:index, :show]
    resources :events, only: [:index, :show]
    get 'join/:id',              to: 'events#join',           as: 'join_event'
    get  'events/:id/photo' , to: 'events#image_details' , as: 'event_photos'
    resources :feedbacks, only: [:new, :create]
    resources :services , only: [:index , :show]
    get 'service/get_service' , to: "services#get_service"
    resources :forms , only: [:index]
    resources :house_rules , only: [:index , :show]
    resource :user, only: [:show, :edit, :update] do
      member do
        get 'password'
        get 'e_walet' => 'users#e_walet'
        patch 'update_password'
        put 'update_password'
        get 'get_users' => 'users#get_users', as: 'get_users'
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

    # resources :events do



    resources :homes, only: [:index]


    resources :privileges, only: [:index, :show] do
      collection do
        post 'redeem_previlege'
        get 'my_privileges'
        post 'delete_my_privilege'
      end
    end

    resources :courses, only: [:index, :show]

    get 'bookings/check_booking' => 'bookings#check_booking'
    post 'bookings/make_a_booking' => 'bookings#make_a_booking'
    post 'bookings/delete_my_booking' => 'bookings#delete_my_booking'
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
  get 'service/get_service' , to: "services#get_service"
end

