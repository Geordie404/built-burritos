defmodule Chat.Burrito do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query # add Ecto.Query

  schema "burritos" do
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
    field :cheese, :boolean, default: false
    field :cilantro, :boolean, default: false
    field :onion, :boolean, default: false
    field :jalapeno, :boolean, default: false
    field :fajita, :boolean, default: false
    field :salsa, :boolean, default: false
    field :habanero, :boolean, default: false
    field :pico, :boolean, default: false
    field :toppings, :string
    field :calories, :integer, default: 0
    field :protein_grams, :integer, default: 0
    field :price, :float, default: 0.00
    field :purchased, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(burrito, attrs) do
    burrito
    |> cast(attrs, [:name, :message, :time, :date,
      :base, :protein, :extra, :rice, :beans,
      :cheese, :cilantro, :onion, :jalapeno, :fajita, :salsa, :habanero, :pico,
      :toppings, :calories, :protein_grams, :price, :purchased])

    |> capitalize(attrs, :name)

    |> validate_required([:name, :message, :time, :date,
      :base, :protein, :extra, :rice, :beans,
      :cheese, :cilantro, :onion, :jalapeno, :fajita, :salsa, :habanero, :pico,
      :toppings, :calories, :protein_grams, :price, :purchased])

    |> get_macros_and_price()

  end

  defp capitalize(changeset, attrs, field) do
    cast(changeset, Map.update!(attrs, to_string(field), &String.capitalize/1), [field])
  end

  def get_all_burritos(limit \\ 200) do
    Chat.Burrito
    |> limit(^limit)
    |> order_by(desc: :inserted_at)
    |> Chat.Repo.all()
  end


  def get_user_burritos(name, limit \\ 100) do
    # query that gets burritos by name only if purchased
    query = from burrito in Chat.Burrito,
            where: burrito.name == ^name and burrito.purchased == :true,
            limit: ^limit,
            order_by: [desc: :inserted_at]

    Chat.Repo.all(query)
  end

  def purchase_burrito() do
    # updates a burrito to have purchase set to true
    Ecto.Query.from(burrito in Chat.Burrito, limit: 1, order_by: [desc: burrito.inserted_at])
    |> Chat.Repo.one
    |> Ecto.Changeset.change(%{purchased: true})
    |> Chat.Repo.update()

  end

  # private function for calculating the nutritional macros as well as the price
  defp get_macros_and_price(changeset) do
    caloric_ingredients = ["base", "protein", "extra", "rice", "beans"]
    caloric_toppings = ["cheese", "cilantro", "onion", "jalapeno", "fajita", "salsa", "habanero", "pico"]
    calorie_map = %{
      "flour" => 150,
      "wheat" => 100,
      "salad" => 30,
      "beef" => 200,
      "chicken" => 150,
      "steak" => 250,
      "plant-based" => 90,
      "x-beef" => 200,
      "x-chicken" => 150,
      "x-steak" => 250,
      "x-plant-based" => 90,
      "white" => 200,
      "brown" => 180,
      "spanish" => 220,
      "black" => 100,
      "pinto" => 120,
      "refried" => 200,
      "cheese" => 150,
      "onion" => 5,
      "jalapeno" => 5,
      "fajita" => 80,
      "salsa" => 20,
      "habanero" => 10,
      "pico" => 40,
    }

    protein_map = %{
      "flour" => 5,
      "wheat" => 10,
      "beef" => 45,
      "chicken" => 50,
      "steak" => 60,
      "plant-based" => 40,
      "x-beef" => 45,
      "x-chicken" => 50,
      "x-steak" => 60,
      "x-plant-based" => 40,
      "white" => 4,
      "brown" => 8,
      "spanish" => 4,
      "black" => 5,
      "pinto" => 6,
      "refried" => 4,
      "cheese" => 10,
      }

    price_map = %{
      "flour" => 6.00,
      "wheat" => 6.00,
      "bowl" => 6.00,
      "salad" => 6.50,
      "beef" => 3.00,
      "chicken" => 3.50,
      "steak" => 4.50,
      "plant-based" => 3.50,
      "x-beef" => 3.00,
      "x-chicken" => 3.50,
      "x-steak" => 4.50,
      "x-plant-based" => 3.50,
      }

    ingredients_filter = changeset.params
    |> Enum.filter(fn {k,_v} -> Enum.member?(caloric_ingredients, k) end)
    |> Map.new
    |> Map.values

    toppings_filter = changeset.params
    |> Enum.filter(fn {k,v} -> Enum.member?(caloric_toppings, k) and v == true end)
    |> Map.new
    |> Map.keys

    # create a list that will be used for calorie calculation

    calorie_list = ingredients_filter ++ toppings_filter

    total_calories = calorie_map
    |> Enum.filter(fn {k,_v} -> Enum.member?(calorie_list, k) end)
    |> Map.new
    |> Map.values
    |> Enum.sum

    total_protein = protein_map
    |> Enum.filter(fn {k,_v} -> Enum.member?(calorie_list, k) end)
    |> Map.new
    |> Map.values
    |> Enum.sum

    total_price = price_map
    |> Enum.filter(fn {k,_v} -> Enum.member?(calorie_list, k) end)
    |> Map.new
    |> Map.values
    |> Enum.sum

    # cast changes so that they show up when inserted into the repo
    cast(changeset, %{calories: total_calories, protein_grams: total_protein, price: total_price}, [:calories, :protein_grams, :price])
  end

end
