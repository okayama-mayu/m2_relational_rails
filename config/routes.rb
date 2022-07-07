Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/parents', to: 'sections#index'
  get '/parents/:id', to: 'sections#show'
  get '/child_table_name', to: 'items#index'
end
