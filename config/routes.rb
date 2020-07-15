Rails.application.routes.draw do
  resources :tests
  resources :games
  resources :users

 namespace :api do
  namespace :v1 do
       resources :games
       resources :users
       get 'games/:id/first', to: 'games#get_first_user', :defaults => { :format => 'json' }
       get 'games/:id/next', to: 'games#next_turn', :defaults => { :format => 'json' }
       post 'games/:id/active', to: 'games#get_active_user', :defaults => { :format => 'json' }
       get 'games/:id/draw', to: 'games#draw', :defaults => { :format => 'json' }
       post 'games/:id/draw', to: 'games#draw', :defaults => { :format => 'json' }
       post 'games/:id/request_drawing', to: 'games#get_request_read_drawings', :defaults => { :format => 'json' }
       post 'games/:id/clear', to: 'games#clear', :defaults => { :format => 'json' }
       post 'games/:id/initialize', to: 'games#init', :defaults => { :format => 'json' }

       post'users/:id/get_session', to: 'users#return_session_data', :defaults => { :format => 'json' }
       post 'login', to: 'users#login', :defaults => { :format => 'json' }
       post 'logout', to: 'users#logout', :defaults => { :format => 'json' }

      # get 'games/:id/initiate', to: 'games#get_active_user', :defaults => { :format => 'json' }


  end
 end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
