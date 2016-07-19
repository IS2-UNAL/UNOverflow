Rails.application.routes.draw do
  resources :tags do
    member do
      get 'questionsByTag', to: :questionsByTag
    end
  end
  resources :likes_comments_by_users
  resources :images
  resources :comments
  resources :posts do
    collection do
      post 'addImage', to: :addImage
      get 'myPosts', to: :myPosts
      get 'lastDay', to: :lastDay
      get 'lastWeek', to: :lastWeek
      get 'lastMonth', to: :lastMonth
      get 'suggest', to: :suggest
      get 'search', to: :search
    end


  end
  devise_for :users, :path  => '', :path_names => {:sign_in => 'loginHasAnImposibleURLBecauseWhereAreGoingToUseAModal',:sign_out=>'logout'}
  root to: 'page#index'
  #get "/contactUS" =>  :contactUS as: 'contact'
  controller :page do
    post "contactUS" => :contactUS
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
