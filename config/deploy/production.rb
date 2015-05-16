set :stage, :production

role :app, %w{deployerdemo@knowledge.logicalbricks.com}
role :web, %w{deployerdemo@knowledge.logicalbricks.com}
role :db,  %w{deployerdemo@knowledge.logicalbricks.com}

server 'knowledge.logicalbricks.com', user: 'deployerdemo', roles: %w{web app db}

set :deploy_to, "/home/deployerdemo/apps/#{fetch(:application)}"

set :branch, ENV["REVISION"] || ENV["BRANCH_NAME"] || "master"
