# Hasura GraphQL Engine

Hasura GraphQL Engine is a blazing-fast GraphQL server that gives you **instant, realtime GraphQL APIs over Postgres**, with [**webhook triggers**](event-triggers.md) on database events, and [**remote schemas**](remote-schemas.md) for business logic.

Hasura helps you build GraphQL apps backed by Postgres or incrementally move to GraphQL for existing applications using Postgres.

Read more at [hasura.io](https://hasura.io) and the [docs](https://docs.hasura.io).

------------------

![Hasura GraphQL Engine Demo](assets/demo.gif)

------------------

![Hasura GraphQL Engine Realtime Demo](assets/realtime.gif)

-------------------

## Features

* **Make powerful queries**: Built-in filtering, pagination, pattern search, bulk insert, update, delete mutations
* **Realtime**: Convert any GraphQL query to a live query by using subscriptions
* **Merge remote schemas**: Access custom GraphQL schemas for business logic via a single GraphQL Engine endpoint. [**Read more**](remote-schemas.md).
* **Trigger webhooks or serverless functions**: On Postgres insert/update/delete events ([read more](event-triggers.md))
* **Works with existing, live databases**: Point it to an existing Postgres database to instantly get a ready-to-use GraphQL API
* **Fine-grained access control**: Dynamic access control that integrates with your auth system (eg: auth0, firebase-auth)
* **High-performance & low-footprint**: ~15MB docker image; ~50MB RAM @ 1000 req/s; multi-core aware
* **Admin UI & Migrations**: Admin UI & Rails-inspired schema migrations
* **Postgres** ❤️: Supports Postgres types (PostGIS/geo-location, etc.), turns views to *graphs*, trigger stored functions or procedures with mutations

Read more at [hasura.io](https://hasura.io) and the [docs](https://docs.hasura.io).


## Architecture

The Hasura GraphQL Engine fronts a Postgres database instance and can accept GraphQL requests from your client apps. It can be configured to work with your existing auth system and can handle access control using field-level rules with dynamic variables from your auth system.

You can also merge remote GraphQL schemas and provide a unified GraphQL API.

![Hasura GraphQL Engine architecture](assets/hasura-arch.svg)

## Client-side tooling

Hasura works with any GraphQL client. We recommend using [Apollo Client](https://github.com/apollographql/apollo-client). See [awesome-graphql](https://github.com/chentsulin/awesome-graphql) for a list of clients.

## Add business logic

GraphQL Engine provides easy-to-reason, scalable and performant methods for adding custom business logic to your backend:

### Remote schemas

Add custom resolvers in a remote schema in addition to Hasura's Postgres-based GraphQL schema. Ideal for use-cases like implementing a payment API, or querying data that is not in your database - [read more](remote-schemas.md).

### Trigger webhooks on database events

Add asynchronous business logic that is triggered based on database events.
Ideal for notifications, data-pipelines from Postgres or asynchronous
processing - [read more](event-triggers.md).

### Derived data or data transformations

Transform data in Postgres or run business logic on it to derive another dataset that can be queried using GraphQL Engine - [read more](https://docs.hasura.io/1.0/graphql/manual/queries/derived-data.html).


## Brand assets

Hasura brand assets (logos, the Hasura mascot, powered by badges etc.) can be
found in the [assets/brand](assets/brand) folder. Feel free to use them in your
application/website etc. We'd be thrilled if you add the "Powered by Hasura"
badge to your applications built using Hasura. ❤️

<div style="display: flex;">
  <img src="assets/brand/powered_by_hasura_blue.svg" width="150px"/>
  <img src="assets/brand/powered_by_hasura_white.svg" width="150px"/>
</div>

```html
<!-- For light backgrounds -->
<a href="https://hasura.io">
  <img width="150px" src="https://graphql-engine-cdn.hasura.io/img/powered_by_hasura_blue.svg" />
</a>

<!-- For dark backgrounds -->
<a href="https://hasura.io">
  <img width="150px" src="https://graphql-engine-cdn.hasura.io/img/powered_by_hasura_white.svg" />
</a>
```

## License

The core GraphQL Engine is available under the [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0) (Apache-2.0).

All **other contents** (except those in [`server`](server), [`cli`](cli) and
[`console`](console) directories) are available under the [MIT License](LICENSE-community).
This includes everything in the [`docs`](docs) and [`community`](community)
directories.

