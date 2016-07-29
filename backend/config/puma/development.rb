threads 0, 8

pidfile 'tmp/pids/puma.pid'

bind 'tcp://0.0.0.0:8080'

on_worker_boot do
  puts 'PUMA IS TAKING OFF!'
end

on_worker_shutdown do
  puts 'PUMA HAWK DOWN!'
end
