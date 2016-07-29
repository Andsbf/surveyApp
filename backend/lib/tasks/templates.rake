namespace :templates do
  desc 'Create or update templates'
  task upsert: :environment do
    template_configs.each do |config|
      template = Template.where(slug: config[:slug]).first
      if template
        puts "Updating template: #{config[:slug]}"
        template.update_attributes(config)
      else
        puts "Creating template: #{config[:slug]}"
        Template.create!(config)
      end
    end
  end

  def template_configs
    files = Dir[Rails.root.join("config", "templates", "*")]
    files.map do |file|
      YAML.load(ERB.new(File.read(file)).result)
    end
  end
end
