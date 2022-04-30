defmodule ChatWeb.Schema.Burrito do
  use Absinthe.Schema.Notation

  alias ChatWeb.Resolvers

  @desc "A Burrito"
  object :burrito do
    field :name, :string
    field :message, :string
    field :time, :string
    field :date, :string
    # ingredient fields
    field :base, :string
    field :protein, :string
    field :extra, :string
    field :rice, :string
    field :beans, :string
    # toppings fields
    field :cheese, :boolean
    field :cilantro, :boolean
    field :onion, :boolean
    field :jalapeno, :boolean
    field :fajita, :boolean
    field :salsa, :boolean
    field :habanero, :boolean
    field :pico, :boolean
    field :toppings, :string
    field :calories, :integer
    field :protein_grams, :integer
    field :price, :float
    field :purchased, :boolean
  end

  object :get_burritos do
    @desc """
    Get a list of products
    """

    field :burritos, list_of(:burrito) do
      resolve(&Resolvers.Burrito.list_burritos/2)
    end
  end
end


# {
#   burritos {
#     name
#     message
#     time
#     date
#     base
#     protein
#     extra
#     rice
#     beans
#     cheese
#     cilantro
#     onion
#     jalapeno
#     fajita
#     habanero
#     pico
#     toppings
#     calories
#     proteinGrams
#     price
#     purchased
#   }
# }
