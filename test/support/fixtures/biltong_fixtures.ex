defmodule Biltongly.BiltongFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Biltongly.Biltong` context.
  """

  @doc """
  Generate a box.
  """
  def box_fixture(attrs \\ %{}) do
    {:ok, box} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Biltongly.Biltong.create_box()

    box
  end
end
