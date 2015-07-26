root = "/home/deployer/apps/best_sites_24/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.best_sites_24.sock"
worker_processes 2
timeout 30
