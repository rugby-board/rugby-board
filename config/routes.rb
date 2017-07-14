Rails.application.routes.draw do
  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      resource :dict, only: [:show]
      resources :news, only: [:create, :show, :update, :destroy]
      post 'news/highlight/:id' => 'news#highlight'
      post 'news/unhighlight/:id' => 'news#unhighlight'
      get 'list' => 'news#list'
      get 'index' => 'news#home'
    end
  end

  # 404 page
  # match "*path", via: :all, to: "index#error_404"
end
