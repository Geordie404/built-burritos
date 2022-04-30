defmodule Chat.Repo.Migrations.Createburrito do
  use Ecto.Migration
  def change do
    create table(:burritos) do
      add :name, :string
      add :message, :string
      add :time, :string
      add :date, :string
      add :base, :string
      add :protein, :string
      add :beans, :string
      add :extra, :string
      add :rice, :string
      add :cheese, :boolean
      add :cilantro, :boolean
      add :onion, :boolean
      add :jalapeno, :boolean
      add :fajita, :boolean
      add :salsa, :boolean
      add :habanero, :boolean
      add :pico, :boolean
      add :toppings, :string
      add :calories, :integer
      add :protein_grams, :integer
      add :price, :float
      add :purchased, :boolean, default: false

      timestamps()
    end
  end
end
