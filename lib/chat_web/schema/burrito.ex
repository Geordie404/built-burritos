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

    # list all burritos
    object :burritos do
      field :burritos, list_of(:burrito) do
        resolve(&Resolvers.Burrito.list_burritos/2)
      end

      #list all burritos from a specified name
      field :name, :string
      field :purchased_by, list_of(:burrito) do
        arg :name, non_null(:string)
        resolve(&Resolvers.Burrito.named_burritos/2)
      end
    end


  @doc"""
  all burritos schema fields:
    burritos {
        name
        message
        time
        date
        base
        protein
        extra
        rice
        beans
        cheese
        cilantro
        onion
        jalapeno
        fajita
        habanero
        pico
        toppings
        calories
        proteinGrams
        price
        purchased
    }

  Get list of all burritos

  Sample query:

    {
      burritos {
        name
        message
        date
        base
        protein
        extra
        toppings
        calories
        proteinGrams
        price
      }
    }

  Get burritos by name query:

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

  query variables:

  {
    "name" : "Geordie"
  }

  !  be sure to capitalize first letter of name in search
  """
end
