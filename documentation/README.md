# Sleuth Documentation

Welcome to Sleuth! Let's show you around.

- [Architecture](#Architecture)
- [Data Brokers](./data_brokers.md)
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
