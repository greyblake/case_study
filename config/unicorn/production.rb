app_path = "/home/www/apps/case_study/current"

# Set unicorn options
worker_processes 1
preload_app true
timeout 180
listen "/tmp/case_study.unicorn.sock"

# Fill path to your app
working_directory app_path

# Should be 'production' by default, otherwise use other env
rails_env = 'production'

# Log everything to one file
stderr_path "#{app_path}/log/unicorn.log"
stdout_path "#{app_path}/log/unicorn.log"

# Set master PID location
pid "#{app_path}/tmp/pids/unicorn.pid"

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end
