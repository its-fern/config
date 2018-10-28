# frozen_string_literal: true

file '.pryrc', <<~CODE
  require 'awesome_print'

  AwesomePrint.defaults = {
    indent: 2,
    index: false
  }

  AwesomePrint.pry!
CODE

file '.rubocop.yml', <<~HEREDOC
  AllCops:
    TargetRubyVersion: 2.5
    Include:
      - '**/config.ru'
      - '**/Rakefile'
    Exclude:
      - 'config/**/*'
      - 'db/**/*'
      - 'log/**/*'
      - 'vendor/**/*'
      - 'Gemfile*'

  Layout/AlignHash:
    Enabled: false

  Layout/AlignParameters:
    EnforcedStyle: with_fixed_indentation

  Layout/MultilineMethodCallIndentation:
    EnforcedStyle: indented

  # Allow DSL-style method calls w/ aligned arguments. The example below would
  # fail this linter because of the `has_many` line:
  # class Thing < ActiveRecord::Base
  #   belongs_to :stuff
  #   has_many   :items
  # end
  Layout/SpaceBeforeFirstArg:
    Enabled: false

  Lint/Debugger:
    Enabled: true
    Severity: error

  Lint/EnsureReturn:
    Enabled: true
    Severity: error

  Metrics/AbcSize:
    Max: 20

  Metrics/BlockLength:
    Exclude:
      - 'config/routes.rb'
      - 'lib/tasks/**/*.rake'
      - 'spec/**/*.rb'

  Metrics/ClassLength:
    Enabled: false

  Metrics/LineLength:
    Max: 120

  Metrics/MethodLength:
    Max: 14

  Rails:
    Enabled: true

  Naming/FileName:
    Exclude:
      - 'Gemfile*'

  Naming/VariableNumber:
    EnforcedStyle: snake_case

  Style/Documentation:
    Enabled: false

  Rails/HttpPositionalArguments:
    Enabled: false

HEREDOC

file 'Gemfile', <<~CODE
  source 'https://rubygems.org'

  ruby File.read('.ruby-version').chomp if File.exist?('.ruby-version')

  # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
  gem 'rails', '~> 5.2.1'
  gem 'pg', '>= 0.18', '< 2.0'
  gem 'puma', '~> 3.11'

  gem 'active_model_serializers'

  # Use ActiveModel has_secure_password
  # gem 'bcrypt', '~> 3.1.7'
  gem 'devise'

  # Reduces boot times through caching; required in config/boot.rb
  gem 'bootsnap', '>= 1.1.0', require: false

  group :development, :test do
    gem 'awesome_print'
    gem 'faker'
    gem 'pry-rails'
    gem 'pry-byebug'
    gem 'rspec-collection_matchers'
    gem 'rspec-rails'
    gem 'shoulda-matchers'
    gem 'factory_bot'
    gem 'factory_bot_rails'
    # gem 'chromedriver-helper'
  end

  group :development do
    # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
    gem 'web-console', '>= 3.3.0'
    gem 'listen', '>= 3.0.5', '< 3.2'
    # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
    gem 'spring'
    gem 'spring-watcher-listen', '~> 2.0.0'
  end

CODE

run 'bundle install'

rails_command 'db:create'

after_bundle do
  generate('rspec:install')

  inject_into_file 'spec/rails_helper.rb', after: ")\nend\n" do
    <<~CODE

      Shoulda::Matchers.configure do |config|
        config.integrate do |with|
          with.test_framework :rspec

          with.library :rails
        end
      end

    CODE
  end

  inject_into_file 'spec/rails_helper.rb', after: "RSpec.configure do |config|\n" do
    "  config.include FactoryBot::Syntax::Methods\n\n"
  end

  inject_into_file 'config/application.rb', after: "class Application < Rails::Application\n" do
    "    config.active_record.schema_format = :sql\n\n"
  end
end
