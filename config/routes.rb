Rails.application.routes.draw do
  get 'index' => 'index#index'
  get 'about' => 'index#about'

  get 'live' => 'live#index'
  
  get 'news' => 'news#list'
  get 'news/feed' => 'news#feed'

  get 'admin' => 'news#admin'
  post 'news/create' => 'news#create'
  delete 'news/delete' => 'news#delete'

  root 'index#index'
end
