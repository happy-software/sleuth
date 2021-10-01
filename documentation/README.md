# Sleuth Documentation

Welcome to Sleuth! Let's show you around.

- [Architecture](#Architecture)
- [Configuration module](./configuration.md)

# Architecture

The following is the structure of the application, with a single-line explanation for each directory. This was generated
using the `tree` command at the root directory:

```bash
# only list directories, and ignore these directories

tree -d -I 'tmp|spec|channels|mailers|views|bin|log|public|storage|vendor'
```

- `app` - where all the application code lives, except tests and one-off commands/rake tasks
- `app/controllers` - where http(s) requests get routed to
- `app/jobs` - things that run in background processes, or kick off background processes
- `app/models` - Ruby classes that represent database tables
- `app/modules/configuration` - Ruby classes representing `yml` files found in the `config/` directory
- `app/services` - APIs for talking to external vendors, data brokers, etc
- `app/services/<broker>/domain` - models that represent the `<broker>`'s business logic, such as a `Person`
- `app/services/<broker>/parsers` - models that parse responses (html, json, etc) provided by `<broker>` into usable
  code for us

More information about data brokers is available in the [Data Brokers](##Data Brokers) section.

## Data Brokers

A **Data Broker** is a service that aggregates data about people, and exposes it via a Search. Results are usually sold,
but not necessarily. These services aggregate information about people across the internet, and will often provide a way
to opt-out of being included in search results.

In the application, a data broker service is what's used to interact with the data broker (e.g. Spokeo). Let's break
down the structure of the `Spokeo` service to illustrate how the application works.

### Spokeo

Suppose that this service (`app/services/spokeo/`) has one file at the base of the directory -- the `search.rb` file.
This means that the way that you can interact with Spokeo is through the `search` API. This API is not a REST API
necessarily. It's just a Ruby class that can interact with Spokeo somehow. Typically, rest APIs will be named `api.rb`
-- referring to a REST API client that interacts with a third-party using HTTP requests.
