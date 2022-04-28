defmodule Chat.Repo.Migrations.BurritoProteinPrice do
  use Ecto.Migration

  def change do
    alter table("burritos") do
      add :protein_grams, :integer
      add :price, :integer
    end
  end
end
