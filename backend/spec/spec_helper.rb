require 'simplecov'
SimpleCov.start 'rails'

ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

require 'sidekiq/testing'

if ENV['CIRCLE_ARTIFACTS']
  dir = File.join('..', '..', '..', ENV['CIRCLE_ARTIFACTS'], 'coverage')
  SimpleCov.coverage_dir(dir)
  SimpleCov.add_filter 'vendor'
  SimpleCov.start
end

RSpec.configure do |config|
  require 'mongoid-rspec'
  config.include Mongoid::Matchers, type: :model

  config.after(:suite) do
    Fabrication.clear_definitions
  end

  config.profile_examples = 10

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  Kernel.srand config.seed
  config.seed = srand && srand % 0xFFFF
end
