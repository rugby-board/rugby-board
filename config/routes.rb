Rails.application.routes.draw do
  get 'index' => 'index#index'
  get 'about' => 'index#about'

  get 'live' => 'live#index'
  
  get 'news' => 'news#list'
  get 'news/new' => 'news#new'
  post 'news/create' => 'news#create'

  root 'index#index'
end
