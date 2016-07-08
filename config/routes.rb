Rails.application.routes.draw do
  devise_for :users, :path  => '', :path_names => {:sign_in => 'loginHasAnImposibleURLBecauseWhereAreGoingToUseAModal',:sign_out=>'logout'}
  root to: 'page#index'
  #get "/contactUS" =>  :contactUS as: 'contact'
  controller :page do
    post "contactUS" => :contactUS
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
