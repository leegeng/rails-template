insert_into_file "config/routes.rb", before: /^end/ do
  if use_active_admin
    <<-'RUBY'
  
  authenticate :admin_user do
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
    RUBY
  else
    <<-'RUBY'
  
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
    RUBY
  end
end

insert_into_file "config/routes.rb", before: /^end/ do
  <<-'RUBY'
  
  namespace :api do
    get '/home/index' => 'home#index'
  end
  RUBY
end

insert_into_file "config/routes.rb", before: /^end/ do
  <<-'RUBY'
  root 'home#index'
  RUBY
end

insert_into_file "config/routes.rb", before: /^end/ do
  <<-'RUBY'

  %w( 404 422 500 ).each do |code|
    get code, :to => "errors#show", :code => code
  end

  get 'health_check', to: 'home#health_check'
  RUBY
end
