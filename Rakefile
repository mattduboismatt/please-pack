# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

if Rails.env.development? || Rails.env.test?
  require "rspec/core/rake_task"

  namespace :spec do
    desc "Run all test suites"
    task all: ["spec"]
  end

  # Rubocop
  require "rubocop/rake_task"
  RuboCop::RakeTask.new(:rubocop) do |task|
    task.options = ["-D"]
  end

  task(:default).clear.enhance(["rubocop", "spec:all", "teaspoon"])
end
