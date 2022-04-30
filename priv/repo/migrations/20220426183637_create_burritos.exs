defmodule Chat.Repo.Migrations.CreateBurritos do
  use Ecto.Migration

  def change do
    create table(:burritos) do
      add :burrito, :boolean
      add :name, :string
      add :message, :string
      add :time, :string

      add :cheese, :boolean
      add :cilantro, :boolean
      add :onion, :boolean
      add :jalapeno, :boolean
      add :fajita, :boolean
      add :salsa, :boolean
      add :habanero, :boolean
      add :pico, :boolean

      add :protein_grams
      add :price, :float

      add :purchased, :boolean, default: false

      timestamps()

    end
  end
end
