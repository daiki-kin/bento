Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # 以下追加
  root 'home#index'  # トップページに home#index を設定

  # ユーザー管理
  resources :users, only: [:new, :create, :show]

  # セッション管理（ログイン・ログアウト）
  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # ユーザー登録
  post "/signup", to: "users#create"

  # パスワードリセット
  resources :password_resets, only: [:new, :create, :edit, :update]

  # ユーザーによる投稿
  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  # プロフィール編集
  resource :profile, only: [:edit, :update]

  # いいね
  resources :users do
    get 'liked_posts', on: :member # ユーザーのいいねした投稿一覧
  end
  resources :posts do
    resource :like, only: [:create, :destroy]
  end
  resources :likes, only: [:create, :destroy]

  # お問い合わせ
  get '/terms', to: 'static_pages#terms', as: 'terms'
  get '/privacy', to: 'static_pages#privacy', as: 'privacy'
  get '/contact', to: 'static_pages#contact', as: 'contact'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
