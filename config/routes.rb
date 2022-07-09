Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/sections', to: 'sections#index'
  get '/sections/new', to: 'sections#new'
  get '/sections/:id', to: 'sections#show'
  get '/sections/:id/edit', to: 'sections#edit' 
  get '/items', to: 'items#index'
  get '/items/:id', to: 'items#show' 
  get '/sections/:section_id/items', to: 'section_items#index' 
  post '/sections', to: 'sections#create'
  patch '/sections/:section_id', to: 'sections#update'
  get '/sections/:section_id/items/new', to: 'section_items#new'
  post '/sections/:section_id/items', to: 'section_items#create'
  get '/items/:item_id/edit', to: 'items#edit' 
  patch '/items/:item_id', to: 'items#update'
end
