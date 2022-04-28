defmodule Chat.Repo.Migrations.BurritoCalories do
  use Ecto.Migration

  def change do
    alter table("burritos") do
      add :calories, :integer
    end
  end
end
