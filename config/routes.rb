# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :auth do
        resources :signup, only: %i[index create], path: '/signup/:token'
        post '/email/verification',
             action: :email_verification,
             controller: :email_verification
        post '/login', action: :login, controller: :login
        delete '/logout', action: :logout, controller: :login
      end
      resource :users, only: %i[show update]

      resources :invites, only: %i[create]

      resources :items, only: %i[index create show]
      get '/user/items', action: :user_items, controller: :items

      resource :group_buyings,
               only: %i[create], path: 'group-buying/item/:item_id'
      resources :group_buyings, only: %i[index]
      get '/user/group_buyings', action: :user_items, controller: :group_buyings

      resources :bids, only: %i[index create destroy show], path:
        '/item/:item_id/bid'
      patch '/item/:item_id/reject/bid/:bid_id',
            action: :reject, controller: :bids
      patch '/item/:item_id/like/bid/:bid_id',
            action: :like, controller: :bids
      get '/item/:item_id/top-bids', action: :top_bids, controller: :bids

      resources :charges, only: %i[show update index], path: '/charge'
      post '/charge/:item_id/:bid_id', action: :charge_bid, controller: :charges
    end
  end
end
