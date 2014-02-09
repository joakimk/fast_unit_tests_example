# About

An example of how you can create a separate suite of tests within a rails application that tests code which does not depend on rails (so that you can have faster feedback cycles)

## Usage

    bundle
    rake spec:unit # will generate spec files to simulate a large test suite

    time rake spec:unit
    .............. etc.

    Finished in 0.10109 seconds
    1000 examples, 0 failures

    Real        0m0.596s
    User        0m0.518s
    Sys         0m0.075s

## Bundler

Waiting for bundler to boot can add seconds to your unit test run, especially when it adds up ("bundle exec rake" runs "bundle exec rspec" ...).

If you have a Guardfile and run guard with bundle exec, you might want to escape it when running non-rails specs. You can do this by clearing RUBYOPT.

    RUBYOPT='' rspec unit/...

If "time rake --version" takes more than about 100 ms:

* Try using NOEXEC_DISABLE=1 (you can read more about it at https://github.com/mpapis/rubygems-bundler/blob/master/README.md).
* Check that you don't have any zsh plugin or similar that automatically runs bundle exec for rake.

## Rails

When you run a raketask that the non-rails code does not load a callback in Rakefile will be triggered. Edit this to load the particular applciation.

    rake stats --trace

    # Rakefile says: If this was a rails app, we would load its rake tasks here.
    # ...fast_unit_tests_example/Rakefile:20...
