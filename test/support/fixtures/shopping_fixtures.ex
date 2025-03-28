defmodule Biltongly.ShoppingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Biltongly.Shopping` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        description: "some description",
        image_url: "some image_url",
        name: "some name",
        price: 42
      })
      |> Biltongly.Shopping.create_product()

    product
  end

  @doc """
  Generate a cart.
  """
  def cart_fixture(attrs \\ %{}) do
    {:ok, cart} =
      attrs
      |> Enum.into(%{
        owner: 42
      })
      |> Biltongly.Shopping.create_cart()

    cart
  end
end
