defmodule ChatWeb.Schema do
  use Absinthe.Schema

  alias ChatWeb.Schema

  import_types(Schema.Burrito)

  query do
    import_fields(:get_burritos)
  end

end