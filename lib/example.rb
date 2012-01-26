require 'active_support/core_ext'

class Example
  def greet(name)
    if name.blank?
      "Hello, what's your name?"
    else
      "Hello, #{name.capitalize}"
    end
  end
end
