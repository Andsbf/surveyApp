namespace :auto_export do
  desc 'Add Email as a requirement for auto_exports'
  task :add_email_requirement => :environment do |t, args|

    puts 'Beginning ...'

    puts 'Fetching auto exports  ...'

    auto_exports = Export.where(:status.in => ['live', 'inactive'])

    puts 'Updating each one ...'

    auto_exports.each do |auto_export|
      puts "###############################################"
      puts "Updating auto export ID: #{auto_export.id.to_s}"

      auto_export.sub_rules.each do |sub_rule|
        if sub_rule.requirements.present?
          process_sub_rule(sub_rule)
        else
          puts 'Destroying useless sub_rule'
          sub_rule.destroy
        end
      end

      auto_export.requirements.each(&:go_live!)

      puts "Regenerating auto export's mask"
      auto_export.mask = Mask.new(auto_export).generate
      auto_export.save

    end
  end

  def process_sub_rule(sub_rule)
    if sub_rule.requirements.count == 2
      # This covers the case where a auto_export has been created after the
      # the email requirement patch has been in place.
      puts 'Sub-Rule skipped, already has email requirement'
    else
      puts 'Adding email requirement'
      add_email_requirement(sub_rule)
    end
  end

  def add_email_requirement(sub_rule)

    requirement_attributes = {
      implicit: false,
      predicate: 'email',
      operator: 'isset',
      merchant_id: sub_rule.merchant_id,
      type: 'lead-property',
      match_type: 'attribute'
    }

    sub_rule.requirements.where(requirement_attributes).create
  end
end
