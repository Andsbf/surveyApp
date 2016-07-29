namespace :imports do
  desc 'modify old imports to fit the new pattern'
  task 'modify_import_attributes' => :environment do

    EXECUTE = ENV['EXECUTE'] || false
    IMPORT_COUNT = Import.count
    iteration_number = 1

    Import.each do |import|

      if import.source.nil? || import.source.merchant_integration_id.nil? || import.count.nil?
        puts 'Deleting orphaned import'
        import.destroy if EXECUTE
        puts "Finished deleting import #{import.id.to_s}"
      else
        puts 'Changing imports status'
        unless import.status == 'failed'
          import.update_attribute(:status, 'completed') if EXECUTE
          puts "Finished updating status for import #{import.id.to_s}"
        end

        puts 'Deflowering import'
        import.update_attribute(:virgin, false) if EXECUTE
        puts "Finished deflowering #{import.id.to_s}"

        puts "FINISHED UPDATING IMPORT #{import.id.to_s}"
      end

      puts "#{iteration_number} of #{IMPORT_COUNT} completed"
      puts '######################################################'
      iteration_number += 1
    end
  end
end
