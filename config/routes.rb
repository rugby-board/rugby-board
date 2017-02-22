Rails.application.routes.draw do
  get 'index' => 'index#index'
  get 'about' => 'index#about'

  get 'live' => 'live#index'
  
  get 'news' => 'news#list'
  get 'news/feed' => 'news#feed'
  get 'news/:id' => 'news#item'

  get 'admin' => 'admin#index'
  post 'news/create' => 'admin#create'
  post 'news/edit' => 'admin#edit'
  delete 'news/delete' => 'admin#delete'
  post 'news/highlight' => 'admin#highlight'

  root 'index#index'
end
