worker_processes 2
preload_app true
timeout 30
listen 8020

stderr_path "/var/www/edubay/current/log/unicorn.stderr.log"

before_fork do |server, worker|
        defined?(ActiveRecord::Base) and
                ActiveRecord::Base.connection.disconnect!

        old_pid = '/var/www/edubay/current/tmp/pids/unicorn.pid.oldbin'

        if File.exists?(old_pid) && server.pid != old_pid
                begin
                        Process.kill("QUIT", File.read(old_pid).to_i)
                rescue Errno::ENOENT, Errno::ESRCH
                        #
                end
        end
end

after_fork do |server, worker|
        defined?(ActiveRecord::Base) and
                ActiveRecord::Base.establish_connection
end
