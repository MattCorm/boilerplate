Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, controllers: {
    registrations: "registrations",
    sessions: "sessions",
    passwords: 'passwords',
  }
  resource :two_factor_settings, except: [:index, :show]

  resources :bp_tests do # BOILERPLATE_ONLY
    collection do        # BOILERPLATE_ONLY
      get :mail          # BOILERPLATE_ONLY
    end                  # BOILERPLATE_ONLY
  end                    # BOILERPLATE_ONLY
  namespace :admin do
    root to: 'home#index'

    resources :users
    resources :seo_meta
    resources :bp_tests  do   # BOILERPLATE_ONLY
      collection do           # BOILERPLATE_ONLY
        patch :save_sequence  # BOILERPLATE_ONLY
      end                     # BOILERPLATE_ONLY
      member do               # BOILERPLATE_ONLY
        put :approve          # BOILERPLATE_ONLY
        put :revocate         # BOILERPLATE_ONLY
        put :validate         # BOILERPLATE_ONLY
        put :invalidate       # BOILERPLATE_ONLY
      end                     # BOILERPLATE_ONLY
    end                       # BOILERPLATE_ONLY

    if Rails.env.development?
      get '/styleguide', to: 'static#styleguide'
    end
  end

  if Rails.env.development?
    get '/styleguide', to: 'static#styleguide'
  end

  get "/404", to: "errors#routing"
  post "/404", to: "errors#routing"
  put "/404", to: "errors#routing"
  patch "/404", to: "errors#routing"
  delete "/404", to: "errors#routing"

  get 'robots.txt' => 'application#robots'
end
