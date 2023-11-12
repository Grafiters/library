Rails.application.routes.draw do
  devise_for :users
  root "dashboard#index"
  get 'dashboard/index'

  resources :user
  resources :author do
    collection do
      get 'form'
      post 'create_or_update'
    end
  end

  resources :book, except: [:show] do
    collection do
      get 'form'
      post 'create_or_update'
    end
  end
  scope :api do
    scope :v2 do
      scope :books do
        get '/', to: 'api/book#index'
      end
    end
  end
end
