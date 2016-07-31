Rails.application.routes.draw do
  devise_for :users, :path  => '', :path_names => {:sign_in => 'loginHasAnImposibleURLBecauseWhereAreGoingToUseAModal',:sign_out=>'logout'}
  scope '(:locale)' do
    scope 'admin' do
      resources :tags do
        member do
          get 'questionsByTag', to: :questionsByTag
        end
      end
    end
    resources :likes_comments_by_users do
      collection do
        post 'addLike', to: :addLike
      end
    end
    resources :images
    resources :posts do
      resources :comments, only: [:index,:new,:create]
      collection do
        post 'addImage', to: :addImage
        get 'myPosts', to: :myPosts
        get 'lastDay', to: :lastDay
        get 'lastWeek', to: :lastWeek
        get 'lastMonth', to: :lastMonth
        get 'suggest', to: :suggest
        get 'search', to: :search
        get 'userSuggest', to: :userSuggest
        get 'searchUser', to: :searchUser
        get 'searchTag', to: :searchTag
      end

    end
    resources :comments, only: [:show,:edit,:update,:destroy] do
      collection do
        post 'addImage', to: :addImage
      end
    end
    root to: 'page#index'
    #get "/contactUS" =>  :contactUS as: 'contact'
    controller :page do
      post "contactUS" => :contactUS
    end

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
