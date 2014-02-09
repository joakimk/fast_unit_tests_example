module RailslessRakeTaskRunner
  def self.load_rails_when_needed_with(loader)
    @loader = loader
  end

  def self.load_rails
    raise "You need register a loader" unless @loader
    @loader.call
  end
end

# Try to run no-rails tasks first. Fallback to rails if none is found.
Rake.application.instance_eval do
  module Rake
    class Task
      alias :old_lookup_prerequisite :lookup_prerequisite

      def lookup_prerequisite(prerequisite_name)
        if prerequisite_name == "environment" && !Rake.application.lookup(prerequisite_name)
          RailslessRakeTaskRunner.load_rails
        end
        old_lookup_prerequisite(prerequisite_name)
      end
    end
  end

  def top_level
    if running_a_task? && requested_tasks_exist?
      super
    else
      RailslessRakeTaskRunner.load_rails
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
