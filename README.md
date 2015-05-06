# RSpec::FeatureHelpers

This gem aims to allow developers to write focussed spec files by making heavy use of RSpec's memoization and tagging features. This project is intended to be used in the context of testing a Rails application, although it shouldn't strictly depend on it.

A few things that you get:

### Automatic login using Warden/Devise

`Warden::Test::Helpers` get injected into the context of feature specs automatically. Tag your specs with `logged_in` and you get a user logged in automatically prior to specs:

```ruby
scenario 'test something', :logged_in do
  # now your user should be logged in.
end
```

The following code is executed as part of a `before` block:

```ruby
login_as user
```

In case of using Warden (Devise), the `login_as` method is automatically injected. If you use a different authentication solution, you can still define your own `login_as` method that would log the user in automatically. For example:

```ruby
module MyCustomAuthentication
  def login_as(user)
    # Do it here...
  end
end

RSpec.configure do |config|
  config.include MyCustomAuthentication, type: :feature
end
```

By default, `user` corresponds to a `create(:user)` block which is what FactoryGirl users use. Again, you can customize what the `user` method lends. You can do this globally or on a per scenario, even a per context basis:

```ruby
feature "Administering our site" do
  background do
    visit admin_path
  end

  context 'as an admin', :logged_in do
    # All scenarios in this given context will
    # have an admin_user logged in prior to running.
    let(:user) { create(:admin_user) }

    scenario 'test something' do
      # ...
    end
  end

  context 'as a regular user', :logged_in do
    # All scenarios in this given context will
    # have a regular user logged in prior to running.

    # This will use the fefault memoized user:
    # let(:user) { create(:user) }

    scenario 'test soething' do
      # ...
    end
  end
end
```

### Using Capybara with a JavaScript capable driver

The gem also configures Capybara to run all feature tests using a JavaScript capable driver. This might not work for everyone, but I find that having JS errors surfaced as soon as possible is benefitial to testing only business-critical scenarios.

The gem also cleans up Capybara sessions and reverts it to use the default driver after each feature spec is completed. This way you get a nice and clean state between each spec run.

## Installation

Add this line to your application's Gemfile, into the test group:

```ruby
group :test do
  gem 'rspec-feature_helpers'
end
```

And then execute:

    $ bundle


## Contributing

1. Fork it ( https://github.com/[my-github-username]/rspec-feature_helpers/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
