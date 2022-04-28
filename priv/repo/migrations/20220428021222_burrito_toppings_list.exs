defmodule Chat.Repo.Migrations.BurritoToppingsList do
  use Ecto.Migration

  def change do
    alter table("burritos") do
      add :toppings, :string 
    end

  end
end
