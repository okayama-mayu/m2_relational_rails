Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/sections', to: 'sections#index'
  get '/sections/:id', to: 'sections#show'
  get '/items', to: 'items#index'
  get '/items/:id', to: 'items#show' 
  get '/sections/:section_id/items', to: 'section_items#index' 
end
