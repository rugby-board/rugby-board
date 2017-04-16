Rails.application.routes.draw do
  get 'index' => 'index#index'
  get 'about' => 'index#about'

  get 'live' => 'live#index'
  
  get 'news' => 'news#list'
  get 'results' => 'news#results'
  get 'news/feed' => 'news#feed'
  get 'news/:id' => 'news#item'

  get 'admin' => 'admin#index'
  post 'news/create' => 'admin#create'
  post 'news/edit' => 'admin#edit'
  delete 'news/delete' => 'admin#delete'
  post 'news/highlight' => 'admin#highlight'

  get 'wiki' => 'wiki#event'

  namespace :api do
    namespace :v1 do
      resource :dict, only: [:show]
    end
  end

  root 'index#index'

  match "*path", via: :all, to: "index#error_404"
end
