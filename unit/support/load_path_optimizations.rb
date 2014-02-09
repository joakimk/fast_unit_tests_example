# Adding gems to load path before other stuff so that
# it loads fast (otherwise it takes many seconds to load)

# Also enables loading of gems that are installed from git-refs without bundle exec.

def add_load_path(path)
  full_path = "#{ENV['HOME']}/.gem/#{path}"

  if File.exists?(full_path)
    $: << full_path
  else
    raise("load path missing: #{full_path} (maybe you forgot to bundle?)")
  end
end

@gemdata = File.readlines(File.join(File.dirname(__FILE__), "../../Gemfile.lock"))

def version_for(gem_name)
  found = @gemdata.reverse.find { |line| line.include?("#{gem_name} (") }
  if found
    (found =~ /.+\((.+?)\)/; $1)
  else
    nil
  end
end

def revision_for(gem_name)
  @gemdata.each_with_index { |line, i|
    if line =~ /remote:.+?#{gem_name}.+/
      @gemdata[i+1] =~ /revision: (.+)/
      return $1[0, 12] if $1
    end
  }

  nil
end

def add_gem(name)
  if revision = revision_for(name)
    add_load_path "bundler/gems/#{name}-#{revision}/lib"
  elsif version = version_for(name)
    add_load_path "gems/#{name}-#{version_for(name)}/lib"
  else
    raise "Could not find version for #{name}"
  end
end

def add_load_path(path)
  full_path = "#{ENV["HOME"]}/.rvm/gems/ruby-1.9.3-p194@fast_unit_tests_example/#{path}"
  raise("load path missing: #{full_path}") unless File.exists?(full_path)
  $: << full_path
end

rails_version = File.readlines(File.join(File.dirname(__FILE__), "../../Gemfile")).
                     find { |line| line.include?("'rails'") }.split.last.gsub("'",'')

add_load_path "gems/activesupport-#{rails_version}/lib"
# add_gem "foo"
