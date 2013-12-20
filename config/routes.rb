Osp::Application.routes.draw do

constraints(host: /^www\./i) do
  match '(*any)' => redirect { |params, request|
    URI.parse(request.url).tap { |uri| uri.host.sub!(/^www\./i, '') }.to_s
  }
end

resources :users do
  resources :messages do
    collection do
      post :delete_selected
    end
  end
end

resources :images do
  collection do
    delete 'destroy_multiple'
  end
end

resources :user_sessions, :dashboards, :static_pages, :news, :media
resources :abouts, :albums, :tournaments, :teams_emails
match 'login' => 'user_sessions#new', :as => :login
match '/auth/facebook/callback' => 'user_sessions#fast_login'
match 'logout' => 'user_sessions#destroy', :as => :logout
match 'logowanie' => 'user_sessions#new', :as => :login
match 'rejestracja' => 'users#new', :as => :rejestracja
match 'about' => 'static_pages_#about'
match 'kontakt' => 'static_pages_#kontakt'
match 'galeria' => 'static_pages_#galeria'
match 'resethasla' => 'static_pages#resethasla'
match 'admin_panel' => 'static_pages_#admin_panel'
match 'rss_comments' => 'static_pages_#rss_comments'
match '/dashboards/add_comment' => 'dashboards#add_comment'
match '/news/add_comment' => 'news#add_comment'
match '/dashboards/destroy_comment/:id' => 'dashboards#destroy_comment', :as => 'destroy_comment'
match '/news/destroy_comment/:id' => 'news#destroy_comment', :as => 'destroy_comment'
match '/static_pages/contact' => 'static_pages#contact'
match '/static_pages/reset_pass' => 'static_pages#reset_pass'
root :to => "static_pages_#start"

match 'potwierdz/:id' => 'users#potwierdz', :as => 'potwierdz'
match 'odwolaj/:id' => 'users#odwolaj', :as => 'odwolaj'
match 'reset_avatar/:id' => 'users#reset_avatar', :as => 'reset_avatar'
match 'upload_avatar/:id' => 'users#upload_avatar', :as => 'upload_avatar'

end
