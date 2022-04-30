defmodule ChatWeb.Schema do
  use Absinthe.Schema

  alias ChatWeb.Schema

  import_types(Schema.Burrito)

  query do
    import_fields(:all_burritos)
    import_fields(:burritos_by_name)
  end

end
