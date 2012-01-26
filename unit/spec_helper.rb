$: << File.expand_path(File.join(File.dirname(__FILE__), "../lib"))
$: << File.expand_path(File.join(File.dirname(__FILE__), "."))

require 'support/load_path_optimizations'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true

  # Ignore some rspec noise
  reporter = config.reporter
  def reporter.message(message)
    messages_to_ignore = [
      "\nAll examples were filtered out; ignoring {:focus=>true}",
      "Run options: include {:focus=>true}"
    ]
    unless messages_to_ignore.include?(message)
      notify :message, message
    end
  end

  config.before(:suite) do
    # Only load if i18n has been required
    if defined?(I18n)
      I18n.default_locale = :sv
      I18n.locale = :sv
      I18n.load_path += Dir[File.join(File.dirname(__FILE__), "../config/locales/*.yml")]
      I18n.load_path += Dir[File.join(File.dirname(__FILE__), "../config/locales/*/*.yml")]
      I18n.reload!
    end
  end
end
