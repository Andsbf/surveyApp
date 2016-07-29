namespace :leads do
  desc 'Set identified status for all the leads'
  task :identify, [:id] => :environment do |t, args|
    id = args.id.presence

    puts 'Beginning ...'
    Merchant.order([:id, :asc]).where(:id.gte => id).each do |merchant|
      print "Processing merchant #{merchant.id} ... "
      merchant.leads.identified.update_all(identified: true)
      puts 'Done'
    end
  end
end
