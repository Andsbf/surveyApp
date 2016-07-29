namespace :events do
  desc 'Migrate event data to the new structure'
  task :migrate => :environment do
    print 'Updating extra_params to context ...'
    Event.all.rename(extra_params: :context)
    puts " Donez\n"

    print 'Migrating Event data ...'
    Event.each do |event|
      event.properties[:value] = event.value
      event.save
      puts '.'
    end

    puts " Donez!"
  end
end
