namespace :exports do
  desc 'modify old exports to fit the new pattern'
  task 'modify_export_attributes' => :environment do

    EXECUTE = ENV['EXECUTE'] || false
    EXPORT_COUNT = Export.count
    iteration_number = 1

    Export.each do |export|

      # remove orphaned exports
      if export.destination_id.nil? && export.merchant_integration.nil?
        puts "deleting orphaned export #{export.id.to_s}"
        puts "DELETE: #{export.id.to_s}"
        export.destroy if EXECUTE
        puts "FINISHED THE UPDATE - deleted export"
      else
        puts "adding the source attribute for #{export.id.to_s}"
        case export.source_type
        when 'List'
          source = export.source_type.constantize.find(export.source_id)
          list_id = source.id.to_s
          list_name = source.name

          export_source = {
            id: list_id,
            name: list_name,
            type: 'list'
          }

          export.update_attribute(:source, export_source) if EXECUTE
          puts "SOURCE: #{export_source}"
          puts "finished adding the source for #{export.id.to_s}"

        when nil
          # if an export has requirements and is not from a list
          # it is an export from a social campaign
          if export.requirements?
            extras = export.requirements.where(predicate: 'participated').first.try(:extras)
            social_campaign_name = extras.present? ? extras['title'] : 'Social Campaign'

            social_campaign_id =
            export.requirements.where(predicate: 'participated').first.try(:value)

            export_source = {
              id: social_campaign_id,
              name: social_campaign_name,
              type: 'social_campaign'
            }

            export.update_attribute(:source, export_source) if EXECUTE
            puts "SOURCE: #{export_source}"
            puts "finished adding the source for #{export.id.to_s}"
          else
            # if source type is nil and there are no requirements, the export
            # is from the entirity of the leads database
            export_source = {
              id: 'all_leads',
              name: 'All Leads',
              type: 'all'
            }

            export.update_attribute(:source, export_source) if EXECUTE
            puts "SOURCE: #{export_source}"
            puts "finished adding the source for #{export.id.to_s}"
          end
        else
          puts "did not recognise the source type for #{export.id.to_s}"
        end

        puts "swapping the type for #{export.id.to_s} if needed"
        if export.status == 'live' || export.status == 'inactive'
          export.update_attribute(:type, 'ongoing') if EXECUTE
          puts "TYPE: ongoing"
        elsif export.status == 'destination_extinct'
          # have to change the type based on the type of actions
          if export.actions? && export.source_type != 'List'
            # on staging we oddly have some List exports whose action are 'ongoing'
            if export.actions.first.type == 'auto-export'
              export.update_attribute(:type, 'ongoing') if EXECUTE
              puts "TYPE: ongoing"
            end
          else
            # if the export does not have actions or the type of the actions
            # is not 'auto-export' then we can set the type to single
            unless export.type == 'single' # type might already be single
              export.update_attribute(:type, 'single') if EXECUTE
              puts "TYPE: single"
            end
          end
        else
          unless export.type == 'single' # type might already be single
            export.update_attribute(:type, 'single') if EXECUTE
            puts "TYPE: single"
          end
        end
        puts "finished swapping the type for #{export.id.to_s}"

        # Change the 'type' of actions if there are actions.
        if export.actions?
          if export.type == 'single'
            # If exports are of type single we can remove their actions. Going
            # forward, single exports will no longer have actions.
            export.actions.each do |action|
              puts "deleting action for #{export.id.to_s}"
              action.destroy if EXECUTE
              puts "DELETE #{action.id.to_s}"
            end
          else
            puts "changing the 'type' of the actions for #{export.id.to_s}"
            export.actions.each do |action|
              action.update_attribute(:type, 'ongoing-export') if EXECUTE
              puts "ACTION_TYPE: ongoing-export"
            end
            puts "finished changing the 'type' of the actions for #{export.id.to_s}"
          end
        end

        # Change the status if needed
        puts 'Starting changing status'
        if export.status == 'live' || export.status == 'inactive'
          # Don't change the status if an export is ongoing
          puts 'Ongoing export so no status change'
        else
          if export.type == 'single' && export.status != 'failed'
            export.update_attribute(:status, 'completed') if EXECUTE
            puts 'Changed status to completed'
          end
        end
        puts 'Finished updating status'

        # old exports should not be virgins
        export.update_attribute(:virgin, false) if EXECUTE
        puts "VIRGIN: false"
        puts "deflowering #{export.id.to_s}"

        #remove the superfluous keys from the document
        puts "removing source_id for #{export.id.to_s}"
        export.unset('source_id') if EXECUTE
        puts "removing source_type for #{export.id.to_s}"
        export.unset('source_type') if EXECUTE
        puts "removing ephemeral for #{export.id.to_s}"
        export.unset('ephemeral') if EXECUTE
        puts "removing filter for #{export.id.to_s}"
        export.unset('filter') if EXECUTE

        puts "FINISHED THE UPDATE FOR #{export.id.to_s}"
      end
      puts "#{iteration_number} of #{EXPORT_COUNT} completed"
      puts '#########################################'
      iteration_number += 1
    end
    puts "FINISHED UPDATING ALL EXPORTS"
  end
end
