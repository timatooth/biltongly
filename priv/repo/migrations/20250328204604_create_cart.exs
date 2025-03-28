defmodule Biltongly.Repo.Migrations.CreateCart do
  use Ecto.Migration

  def change do
    create table(:cart) do
      add :owner, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
