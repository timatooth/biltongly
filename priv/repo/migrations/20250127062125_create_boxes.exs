defmodule Biltongly.Repo.Migrations.CreateBoxes do
  use Ecto.Migration

  def change do
    create table(:boxes) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
