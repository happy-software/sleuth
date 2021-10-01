# Sleuth Documentation

Welcome to Sleuth! Let's show you around.

- [Architecture](#Architecture)

# Architecture

## Configuration

The application uses `app/modules/configurable.rb` to load `config/<configuration>.yml` files, and use them under the
Ruby `Configuration` namespace.

Let's take a look at the file `app/modules/configuration/lockbox.rb`.

This file looks like:

```ruby
module Configuration
  class Lockbox
    extend Configurable

    configure :lockbox
  end
end
```
The configure keyword is the name of the yml file that lives in the `config/` directory. That yml file specifies
key-value pairs under a Rails environment. This creates a singleton class called `Configuration::Lockbox` that will use
methods loaded from the configuration file.

The sample `config/lockbox.yml` file might look like:

```yml
development:
  encryption_key: "test"

qa:
  encryption_key: "qa-test"

production:
  encryption_key: "actual-key"
```

This means that you will be given a method titled encryption_key for your `Configuration::Lockbox` class, and the value
of it will vary based on the `RAILS_ENV`.

```ruby
# if RAILS_ENV == "development"
Configuration::Lockbox.encryption_key # => "test"

# if RAILS_ENV == "test"
Configuration::Lockbox.encryption_key # => "qa-test"

# if RAILS_ENV == "production"
Configuration::Lockbox.encryption_key # => "actual-key"
```
