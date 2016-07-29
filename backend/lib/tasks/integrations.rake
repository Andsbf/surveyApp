namespace :integrations do
  desc 'Create or update integrations'
  task upsert: :environment do

    integration_configs.each do |config|
      integration = Integration.where(platform: config[:platform]).first
      if integration
        puts "Updating integration: #{config[:name]}"
        integration.update_attributes(config)
      else
        puts "Creating integration: #{config[:name]}"
        Integration.create!(config)
      end
    end
  end

  def integration_configs
    files = Dir[Rails.root.join("config", "integrations", "*")]
    files.map do |file|
      YAML.load(ERB.new(File.read(file)).result)
    end
  end

end
