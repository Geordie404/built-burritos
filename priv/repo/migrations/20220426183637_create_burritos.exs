defmodule Chat.Repo.Migrations.CreateBurritos do
  use Ecto.Migration

  def change do
    create table(:burritos) do
      add :burritos, :string
      add :burrito, :boolean, default: false, null: false
      add :name, :string
      add :message, :string
      add :time, :string

      timestamps()
    end
  end
end
