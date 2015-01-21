# config valid only for Capistrano 3.1
lock '3.2.1'

#General Configuration
set :application, 'yq'
set :deploy_user, 'felippe'
set :scm, :git
set :repo_url, 'git@github.com:felippefpiazza/yq.git'

#Setup RVM
#set :rbenv_type, :system
#set :rbenv_ruby, '2.1.1'
#set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
#set :rbenv_map_bins, %w{rake gem bundle ruby rails}

#Saving some space on the server
set :keep_releases, 5





namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
