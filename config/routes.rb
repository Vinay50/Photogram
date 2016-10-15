Rails.application.routes.draw do
  get 'notifications/link_through'

    get 'profiles/show'

    devise_for :users, :controllers => { registrations: 'registrations' } 

      root 'posts#index'

      resources :posts do 
       	resources :comments
       	member  do 
       		get 'like'
       		get 'unlike'
       	end
      end  

    get ':username', to: 'profiles#show', as: :profile 

    get ':username/edit', to: 'profiles#edit', as: :edit_profile 

    patch ':username/edit', to: 'profiles#update', as: :update_profile 

     get 'notifications/:id/link_through', to: 'notifications#link_through', 
                                        as: :link_through
  
     get 'notifications' => 'notifications#index'

end
