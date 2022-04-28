defmodule Chat.Repo.Migrations.BurritoToppings do
  use Ecto.Migration

  def change do
    alter table("burritos") do
      add :cheese, :boolean, default: false
      add :cilantro, :boolean, default: false
      add :onion, :boolean, default: false
      add :jalapeno, :boolean, default: false
      add :fajita, :boolean, default: false
      add :salsa, :boolean, default: false
      add :habanero, :boolean, default: false
      add :pico, :boolean, default: false
    end
  end
end
