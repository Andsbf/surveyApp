namespace :api_application do

  desc 'Generate a new api application'
  task generate: :environment do
    puts "Enter application name: "
    STDOUT.flush
    app_name = STDIN.gets.strip
    if app_name.size > 0
      app = ApiApplication.generate(app_name)
      puts "Created new app"
      puts "Name: #{app.name}"
      puts "App ID: #{app.app_id}"
      puts "App Secret: #{app.app_secret}"
    end
  end

  desc 'Fix roles on Wishpond applications'
  task fix_roles: :environment do

    WISHPOND_APPS = ["wishpondv1", "wishpond", "shoal", "botstore", "wishmail", "chatty-panda"]
    apps = ApiApplication.where(:name.in => WISHPOND_APPS)
    puts "Fixing roles for:"
    puts apps.pluck(:name)

    apps.update_all(role: "wishpond")
    puts "Fixed!"
  end

end
