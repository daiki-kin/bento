Rails.application.routes.draw do
  # ヘルスチェックとPWA関連
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # トップページ
  root 'home#index'

  # Devise（ユーザー認証）
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # ユーザー管理
  resources :users, only: [:new, :create, :show] do
    get 'liked_posts', on: :member
  end

  # セッション管理（ログイン・ログアウト）
  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  post "/signup", to: "users#create"

  # パスワードリセット
  resources :password_resets, only: [:new, :create, :edit, :update]

  # 投稿関連といいね機能と検索機能
  resources :posts do
    resource :like, only: [:create, :destroy]
    collection do
      get :search
      get :map_search
    end
  end

  # 店舗関連（ショップ詳細）
  resources :shops, only: [:show]

  # プロフィール編集
  resource :profile, only: [:edit, :update]

  # お問い合わせ・規約など
  get '/terms', to: 'pages#terms'
  get '/privacy', to: 'pages#privacy'
  get '/contact', to: 'pages#contact'

  # 開発環境限定
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
