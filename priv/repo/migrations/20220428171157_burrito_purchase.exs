defmodule Chat.Repo.Migrations.BurritoPurchase do
  use Ecto.Migration

  def change do
    alter table("burritos") do
      add :purchased, :boolean
    end

  end
end
