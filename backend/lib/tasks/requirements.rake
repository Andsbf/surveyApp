namespace :requirements do
  desc 'Delete all existing live imiplicit rules'
  task delete_live_implicit: :environment do
    puts 'Beginning ...'

    Requirement.live.implicit.delete_all

    puts 'Finished!'
  end
end
