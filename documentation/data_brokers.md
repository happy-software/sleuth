# Data Brokers

A **Data Broker** is a service that aggregates data about people, and exposes it via a Search. Results are usually sold,
but not necessarily. These services aggregate information about people across the internet, and will often provide a way
to opt-out of being included in search results.

In the application, a data broker service is what's used to interact with the data broker (e.g. Spokeo). Let's break
down the structure of the `Spokeo` service to illustrate how the application works.

## Spokeo

Suppose that this service (`app/services/spokeo/`) has one file at the base of the directory -- the `search.rb` file.
This means that the way that you can interact with Spokeo is through the `search` API. This API is not a REST API
necessarily. It's just a Ruby class that can interact with Spokeo somehow. Typically, rest APIs will be named `api.rb`
-- referring to a REST API client that interacts with a third-party using HTTP requests.
