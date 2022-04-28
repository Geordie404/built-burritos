defmodule Chat.Repo.Migrations.PriceDrop do
  use Ecto.Migration

  def change do
    alter table("burritos") do
      remove :price
      add :price, :float
    end
  end
end
