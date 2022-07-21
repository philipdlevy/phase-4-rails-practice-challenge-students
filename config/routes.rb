Rails.application.routes.draw do
  resources :instructors, only: [:index, :show, :create, :destroy, :update] do
    # Nested resource for students. Helps with routes like instructors/1/students/3
    resources :students, only: [:index, :show]
  end

  resources :students, only: [:index, :show, :create, :destroy, :update]
end
