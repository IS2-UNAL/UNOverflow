Rails.application.routes.draw do
  namespace :api, defaults: {format: :json}  do
        namespace :v1 do
          resources :users, :only => [:show,:index] do
            collection do
              post 'login', to: :login
              post 'reloadUser', to: :reloadUser
            end
          end
          resources :tags_api, :only => [:show,:index,:create,:update,:destroy]
          resources :comments_api, :only => [:show,:create,:update,:destroy]
          resources :posts_api, :only =>[:show,:index,:create,:update,:destroy]
        end

  end
  devise_for :users, :path  => '', :path_names => {:sign_in => 'loginHasAnImposibleURLBecauseWhereAreGoingToUseAModal',:sign_out=>'logout'}
  scope '(:locale)' do
    scope 'admin' do
      resources :tags do
        collection do
          get 'favoriteTags', to: "tags#favoriteTags"
        end
        member do
          post 'subscribeByTag', to: "tags#subscribeByTag"
          delete 'unsubscribeByTag', to: "tags#unsubscribeByTag"
          get 'questionsByTag', to: :questionsByTag
        end
      end
    end
    resources :likes_comments_by_users, except:[:new,:create,:update,:destroy,:index,:show,:edit] do
      collection do
        post 'addLike', to: :addLike
      end
    end
    resources :images, except: [:new,:create,:update,:edit]
    resources :posts do
      resources :comments, only: [:new,:create], except:[:index]
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
        get  'myComments', to: :myComments
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
