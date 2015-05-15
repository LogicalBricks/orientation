set :stage, :production

role :app, %w{deployerdemo@demo-infacto.com}
role :web, %w{deployerdemo@demo-infacto.com}
role :db,  %w{deployerdemo@demo-infacto.com}

server 'demo-infacto.com', user: 'deployerdemo', roles: %w{web app db}

set :branch, ENV["REVISION"] || ENV["BRANCH_NAME"] || "master"
