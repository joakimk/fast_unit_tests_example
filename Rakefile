#!/usr/bin/env rake

require File.expand_path('../lib/tasks/no_rails', __FILE__)

# Try to run no-rails rake tasks first and fallback to rails when none is found.
app = Rake.application

def app.top_level
  if running_a_task? && requested_tasks_exist?
    super
  else
    puts "Rakefile says: If this was a rails app, we would load its rake tasks here."
    #require File.expand_path('../config/application', __FILE__)
    #App::Application.load_tasks
    super
  end
end

def app.running_a_task?
  !(options.show_tasks || options.show_prereqs)
end

def app.requested_tasks_exist?
  top_level_tasks.any? { |task| Rake.application.lookup(task) }
end
