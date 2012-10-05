#!/usr/bin/env rake

# Load all non-rails tasks.
require File.expand_path('../lib/tasks/no_rails.rb', __FILE__)

# Try to run no-rails tasks first. Fallback to rails if none is found.
module LoadRailsTasks
  def self.load
    puts "Rakefile says: If this was a rails app, we would load its rake tasks here."
    #require File.expand_path('../config/application', __FILE__)
    #App::Application.load_tasks
  end
end

Rake.application.instance_eval do
  module Rake
    class Task
      alias :old_lookup_prerequisite :lookup_prerequisite

      def lookup_prerequisite(prerequisite_name)
        if prerequisite_name == "environment" && !Rake.application.lookup(prerequisite_name)
          LoadRailsTasks.load
        end
        old_lookup_prerequisite(prerequisite_name)
      end
    end
  end

  def top_level
    if running_a_task? && requested_tasks_exist?
      super
    else
      LoadRailsTasks.load
      super
    end
  end

  def running_a_task?
    !(options.show_tasks || options.show_prereqs)
  end

  def requested_tasks_exist?
    top_level_tasks.any? { |task| lookup(task) }
  end
end
