defmodule Biltongly.Shopping.CartItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cart_items" do
    field :cart_id, :id
    field :product_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [])
    |> validate_required([])
  end
end
