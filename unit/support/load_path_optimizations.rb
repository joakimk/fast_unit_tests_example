def add_load_path(path)
  full_path = "#{ENV["HOME"]}/.rvm/gems/ruby-1.9.3-p0@fast_unit_tests_example/#{path}"
  raise("load path missing: #{full_path}") unless File.exists?(full_path)
  $: << full_path
end

rails_version = File.readlines(File.join(File.dirname(__FILE__), "../../Gemfile")).
                     find { |line| line.include?("'rails'") }.split.last.gsub("'",'')

add_load_path "gems/activesupport-#{rails_version}/lib"
