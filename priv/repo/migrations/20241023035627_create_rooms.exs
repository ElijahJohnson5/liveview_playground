defmodule Playground.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end
