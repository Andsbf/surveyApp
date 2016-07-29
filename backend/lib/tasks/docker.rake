namespace :docker do

  desc 'Build the docker image'
  task :build do
    `docker build -t wishpond/jambo #{Rails.root}`
  end

  desc 'Run webserver from docker'
  task :web do
    port = ENV['JAMBO_PORT'].presence || 3010
    `docker run wishpond/jambo /usr/bin/start-server -p #{port}:80`
  end

end
