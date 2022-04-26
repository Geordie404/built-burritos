defmodule Chat.Repo.Migrations.MoreBurritoColumns do
  use Ecto.Migration

  def change do
    alter table("burritos") do
    add :protien, :string
    end
  end

end
