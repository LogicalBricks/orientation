set :stage, :production

role :app, %w{deployerdemo@knowledge.logicalbricks.com}
role :web, %w{deployerdemo@knowledge.logicalbricks.com}
role :db,  %w{deployerdemo@knowledge.logicalbricks.com}

server 'demo-infacto.com', user: 'deployerdemo', roles: %w{web app db}

set :branch, ENV["REVISION"] || ENV["BRANCH_NAME"] || "master"
