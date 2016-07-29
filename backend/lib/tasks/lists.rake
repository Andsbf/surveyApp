namespace :lists do
  desc 'Convert lists to the new format'
  task :modernize_lists => :environment do
    SmartList.all.update_all(type: 'smart')
  end

  desc 'Update lists with new mids'
  task :update_list_mids => :environment do
    puts 'Beginning ...'

    file = File.read("/tmp/jambo_lists_to_update")
    lista = YAML.load(file)

    lista.each do |mid, ids|
      puts "Merchant #{mid}"
      List.where(:_id.in => ids).update_all(merchant_id: mid)
    end

    puts 'Done!'
  end
end
