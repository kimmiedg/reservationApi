Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Namespacing for backward compatibility.
  namespace :v1 do
    resources :reservations
  end
end
