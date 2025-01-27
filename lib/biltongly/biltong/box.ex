defmodule Biltongly.Biltong.Box do
  use Ecto.Schema
  import Ecto.Changeset

  schema "boxes" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(box, attrs) do
    box
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
