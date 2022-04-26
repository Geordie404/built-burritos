defmodule Chat.Repo.Migrations.MoreBurritoColumns3 do
  use Ecto.Migration

  def change do
    alter table("burritos") do
    add :protein, :string
    end
  end
end
