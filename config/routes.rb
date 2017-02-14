Rails.application.routes.draw do
  get 'index/index' => 'index#index'
  get 'index/about' => 'index#about'
  
  get 'news/new' => 'news#new'
  post 'news/create' => 'news#create'

  root 'index#index'
end
