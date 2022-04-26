defmodule Chat.Burrito do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query # add Ecto.Query

  schema "burritos" do
    field :burrito, :boolean, default: false
    field :message, :string
    field :name, :string
    field :time, :string
    # ingredient fields
    field :base, :string
    field :protein, :string
    field :extra, :string
    field :rice, :string
    field :beans, :string

    timestamps()
  end

  @doc false
  def changeset(burrito, attrs) do
    burrito
    |> cast(attrs, [:burrito, :name, :message, :time, :base, :protein, :extra, :rice, :beans])
    |> validate_required([:burrito, :name, :message, :time, :base, :protein, :extra, :rice, :beans])
  end

  def get_messages(limit \\ 20) do
    Chat.Burrito
    |> limit(^limit)
    |> order_by(desc: :inserted_at)
    |> Chat.Repo.all()
  end
end
