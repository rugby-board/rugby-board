Rails.application.routes.draw do
  get 'index' => 'index#index'
  get 'about' => 'index#about'

  get 'live' => 'live#index'
  
  get 'news'    => 'news#list', :channel => "news"
  get 'results' => 'news#list', :channel => "results"
  get 'event/:event_name' => 'news#list', :channel => "events"

  get 'news/feed' => 'news#feed'
  get 'news/:id' => 'news#item'

  get 'admin' => 'admin#index'
  post 'news/create' => 'admin#create'
  post 'news/edit' => 'admin#edit'
  delete 'news/delete' => 'admin#delete'
  post 'news/highlight' => 'admin#highlight'

  get 'wiki' => 'wiki#index'
  get 'wiki/:event_name' => 'wiki#event'

  namespace :api do
    namespace :v1 do
      resource :dict, only: [:show]
      get 'news/:id' => 'news#item'
      get 'list'     => 'news#list'
      get 'index'    => 'news#index'
    end
  end

  root 'index#index'

  match "*path", via: :all, to: "index#error_404"
end
