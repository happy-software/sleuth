# Configuration

The application uses the [`Rails::Application#.config_for`
method](https://api.rubyonrails.org/classes/Rails/Application.html#method-i-config_for) for loading
`config/<configuration>.yml` files.  directory.

## Example config/<filename>.yml file

The sample `config/lockbox.yml` file might look like:

```yml
development:
  encryption_key: "test"

qa:
  encryption_key: "qa-test"

production:
  encryption_key: "actual-key"
```

```ruby
# if RAILS_ENV == "development"
App::Application.config_for(:lockbox).encryption_key # => "test"

# if RAILS_ENV == "test"
App::Application.config_for(:lockbox).encryption_key # => "qa-test"

# if RAILS_ENV == "production"
App::Application.config_for(:lockbox).encryption_key  # => "actual-key"
```
