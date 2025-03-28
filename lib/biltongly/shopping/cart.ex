defmodule Biltongly.Shopping.Cart do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cart" do
    field :owner, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(cart, attrs) do
    cart
    |> cast(attrs, [:owner])
    |> validate_required([:owner])
  end
end
