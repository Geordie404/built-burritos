defmodule Chat.Repo.Migrations.BurritoTimeDate do
  use Ecto.Migration

  def change do
    alter table("burritos") do
      add :date, :string
    end
  end
end
