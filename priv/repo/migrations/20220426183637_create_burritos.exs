defmodule Chat.Repo.Migrations.CreateBurritos do
  use Ecto.Migration

  def change do
    create table(:burritos) do
      add :burrito, :boolean
      add :name, :string
      add :message, :string
      add :time, :string

      timestamps()
    end
  end
end
