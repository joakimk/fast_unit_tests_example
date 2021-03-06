namespace :spec do
  task :unit do
    # simulate a large test suite
    unless File.exists?("unit/example_copy0_spec.rb")
      puts "Making a few spec files (only on first run), may take a few seconds..."
      499.times do |i|
        system("cp unit/example_spec.rb unit/example_copy#{i}_spec.rb")
      end
    end

    spec_helper_path = File.expand_path("unit/spec_helper.rb")
    system("rspec", "-r#{spec_helper_path}", *Dir["unit/**/*_spec.rb"]) || exit(1)
  end
end

task :default => :"spec:unit"
