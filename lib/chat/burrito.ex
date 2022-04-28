defmodule Chat.Burrito do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query # add Ecto.Query

  schema "burritos" do
    field :burrito, :boolean, default: false
    field :message, :string
    field :name, :string
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

    timestamps()
  end

  @doc false
  def changeset(burrito, attrs) do
    burrito
    |> cast(attrs, [:burrito, :name, :message, :time, :date,
     :base, :protein, :extra, :rice, :beans,
     :cheese, :cilantro, :onion, :jalapeno, :fajita, :salsa, :habanero, :pico, :toppings])

    |> validate_required([:burrito, :name, :message, :time, :date,
     :base, :protein, :extra, :rice, :beans,
     :cheese, :cilantro, :onion, :jalapeno, :fajita, :salsa, :habanero, :pico, :toppings])
  end

  def get_burritos(limit \\ 20) do
    Chat.Burrito
    |> limit(^limit)
    |> order_by(desc: :inserted_at)
    |> Chat.Repo.all()
  end
end
