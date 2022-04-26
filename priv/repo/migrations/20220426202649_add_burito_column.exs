defmodule Chat.Repo.Migrations.AddBuritoColumn do
  use Ecto.Migration

  def change do
    alter table("burritos") do
    add :base, :string
  end

  end
end
