# Built Burritos

This project is my submission for the openforce tech challenge

Some Preliminaries:

  * runs on the newest version of Elixir -v 1.13.4
  * uses PostgreSQL for database
  * uses GraphiQL for additional queries
  * PosgreSQL requires username: "postgres" with password: "postgres" as seen config/dev.exs
  * terminal command for this if its not already setup: `$ createuser --superuser postgres`

To start this Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

  additionally...

  * Insert some initial data with `mix run priv/repo/seeds.exs`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Project Details

Built Burritos is an adaptation of my simple phoenix chat therefore some of the file names and general structure still uses "Chat".

The front end is built in HTML and CSS and uses JavaScript for UI manipulation as well as populating the payloads used by the Elixir portion of the project.

Elixir is responsible for the the schema structure and query handling. Elixir and JavaScript communicate through shouts across the configured channel through the utilization of Phoenix's real time socket connection feature.

GraphQL allows for some additional querying options and query visualization and is built on top of the existing PostgreSQL database


## Using the UI

  * enter your name, select your ingredients, then add some toppings
  * the `Build Burrito` button populates the chat box with the details of your burrito
  * once built, you can change the fillings and `Update` your order to see live changes
  * alternatively you can purchase the burrito and start a new one
  * after the burrito has been purchased, you can look at your past purchased burritos
  * the `Your Past Burritos` button will populate the chat box with burritos you have purchased
  * ! the name input acts as a filter for the past burritos and is required to build a burrito

## GraphQL

  * some additional querying options were added using GraphQL through Absinthe, Elixir's GraphQL toolkit
  * this feature can be utilized at [`localhost:4000/graphiql`](http://localhost:4000/graphiql)
  * sample query by name :
  ```
    query ($name: String!){
      purchasedBy(name: $name){
        name
        message
        time
        date
        base
        protein
      }
    }
  ```
* sample query variables:
  ```
    {
      "name" : "Geordie"
    }
  ```

## Important Files:
  * `config/dev.exs` configure PostgreSQL repo
  * `assets/js/user_socket.js` updates UI by interacting with the HTML
  * `lib/chat/burrito.ex` Ecto Schema, changesets, and queries for burritos schema
  * `lib/chat_web/channels/room_channel.ex` middleware between JS and Ecto Repo
  * `lib/chat_web/channels/templates/page/index.html.heex` HTML
  * files important for GraphQL:
    - `lib/chat_web/schema/burrito.ex` Absinthe schema and GraphQL queries
    - `lib/chat_web/resolver/burrito.ex` resolves the queries by hitting the PostgresQL database
    - `lib/chat_web/schema.ex` imports schema and runs a query that hits the resolvers
    - `lib/chat_web/router.ex` router configuration for GraphQL
