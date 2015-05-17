lock '3.4.0'

set :application, 'orientation'
set :scm, "git"
set :repo_url, "git@github.com:LogicalBricks/orientation.git"
set :deploy_to, "/home/deployer/apps/#{fetch(:application)}"

set :ssh_options, {
  forward_agent: true
}

set :log_level, :debug
set :linked_files, %w{ .env config/database.yml }
set :linked_dirs, %w{bin log tmp vendor/bundle public/system public/uploads}

SSHKit.config.command_map[:rake]  = "bundle exec rake"
SSHKit.config.command_map[:rails] = "bundle exec rails"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
  after 'deploy:publishing', 'deploy:restart'

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end

  desc "Install bower"
  task :install_bower do
    on roles(:web) do
      within release_path do
        execute :bower, :install
      end
    end
  end
  before "deploy:compile_assets", "deploy:install_bower"

  after :finishing, 'deploy:cleanup'
end
