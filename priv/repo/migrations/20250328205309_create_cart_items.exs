defmodule Biltongly.Repo.Migrations.CreateCartItems do
  use Ecto.Migration

  def change do
    create table(:cart_items) do
      add :cart_id, references(:cart, on_delete: :nothing)
      add :product_id, references(:products, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:cart_items, [:cart_id])
    create index(:cart_items, [:product_id])
  end
end
