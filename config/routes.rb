AutomatedTestSite::Application.routes.draw do
  resource :timetables, only: [:edit, :update]
  resources :pages
  resources :environments

  match '/run_test' => 'pages#run_test', as: :run_test
  match '/log' => 'pages#test_log', as: :log
  match '/update_code' => 'pages#update_code', as: :update_code
  match '/update_test' => 'pages#update_test', as: :update_test
  match '/update_tag' => 'pages#update_tag', as: :update_tag
  match '/stop' => 'pages#stop_test', as: :stop_test
  match '/list' => 'list#index'
  match '/show/:id' => 'list#show', as: :show_report
  match '/nightly/:id' => 'list#nightly', as: :nightly
  match '/reports' => 'list#reports'

  root :to => 'pages#index'
end
