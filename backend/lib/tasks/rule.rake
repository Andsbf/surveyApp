namespace :rules do
  # Currently this only considers social campaigns in requirements and emails
  # in actions. If you need more automatic updating of resources (ex. lists),
  # then you need to build that functionality in. It would involve dumping a mapping
  # from duplicating the resources and updating them here.

  desc 'Copy rules to different merchant'
  task :dup_transfer, [:WORKFLOW_IDS, :MERCHANT_IDS] => :environment do
    # No mongo logger
    Mongo::Logger.logger.level = nil
    Mongo::Logger.logger = nil

    if ENV['WORKFLOW_IDS'].blank?
      puts 'At least one id in WORKFLOW_IDS (CSV string env var) is needed'
      exit
    end

    if ENV['MERCHANT_IDS'].blank?
      puts 'At least one id in MERCHANT_IDS array (CSV string env var) is needed'
      exit
    end

    WORKFLOW_IDS = ENV['WORKFLOW_IDS'].split(',').map(&:strip)
    MERCHANT_IDS = ENV['MERCHANT_IDS'].split(',').map(&:strip)

    # Load up mapping files.

    File.open("/tmp/wishmail_mappings", 'r') do |file|
      @wishmail_mappings = YAML.load(file.read)
    end

    File.open("/tmp/jambo_sc_mappings", 'r') do |file|
      @sc_mappings = YAML.load(file.read)
    end

    MERCHANT_IDS.each do |mid|
      puts "Processing merchant #{mid}"
      merchant = Merchant.find(mid)
      wishmails = @wishmail_mappings[mid]
      campaigns = @sc_mappings[mid]

      WORKFLOW_IDS.each do |rule_id|
        print "Rule #{rule_id} .. "

        rule = Rule.find(rule_id)
        new_rule = rule.deep_dup

        print 'updating rule .. '
        new_rule.merchant = merchant
        new_rule.name = new_rule.name.gsub(' (2)', '')
        new_rule.save

        print 'updating sub_rules .. '
        new_rule.sub_rules.each do |sub_rule|
          sub_rule.merchant = merchant
          sub_rule.save
        end

        print 'updating requirements .. '
        new_rule.requirements.each do |requirement|
          requirement.merchant = merchant

          # Check for social campaigns
          if requirement.type == 'campaign-event'
            if mapping = campaigns[requirement.value]
              requirement.value = mapping
            end
          end

          requirement.save
        end

        print 'updating actions .. '
        new_rule.actions.each do |action|

          # Check for wishmails
          if action.type == 'send-email' || action.type == 'send-internal-email'
            if mapping = wishmails[action.arguments['wishmail']]
              action.arguments['wishmail'] = mapping
            end
          end

          action.save
        end

        puts "done Rule #{rule_id}"
      end

      puts "done Merchant #{mid}"
    end
  end
end
