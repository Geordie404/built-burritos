defmodule ChatWeb.Schema do
  use Absinthe.Schema
  alias ChatWeb.Schema

  # imports the Absinthe Schema for Burrito
  import_types(Schema.Burrito)

  query do
    # imports the burrito object for GraphiQL queries to resolve
    import_fields(:burritos)
  end

end
