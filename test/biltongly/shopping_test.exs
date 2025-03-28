defmodule Biltongly.ShoppingTest do
  use Biltongly.DataCase

  alias Biltongly.Shopping

  describe "products" do
    alias Biltongly.Shopping.Product

    import Biltongly.ShoppingFixtures

    @invalid_attrs %{name: nil, description: nil, image_url: nil, price: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Shopping.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Shopping.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{name: "some name", description: "some description", image_url: "some image_url", price: 42}

      assert {:ok, %Product{} = product} = Shopping.create_product(valid_attrs)
      assert product.name == "some name"
      assert product.description == "some description"
      assert product.image_url == "some image_url"
      assert product.price == 42
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shopping.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", image_url: "some updated image_url", price: 43}

      assert {:ok, %Product{} = product} = Shopping.update_product(product, update_attrs)
      assert product.name == "some updated name"
      assert product.description == "some updated description"
      assert product.image_url == "some updated image_url"
      assert product.price == 43
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Shopping.update_product(product, @invalid_attrs)
      assert product == Shopping.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Shopping.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Shopping.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Shopping.change_product(product)
    end
  end

  describe "cart" do
    alias Biltongly.Shopping.Cart

    import Biltongly.ShoppingFixtures

    @invalid_attrs %{owner: nil}

    test "list_cart/0 returns all cart" do
      cart = cart_fixture()
      assert Shopping.list_cart() == [cart]
    end

    test "get_cart!/1 returns the cart with given id" do
      cart = cart_fixture()
      assert Shopping.get_cart!(cart.id) == cart
    end

    test "create_cart/1 with valid data creates a cart" do
      valid_attrs = %{owner: 42}

      assert {:ok, %Cart{} = cart} = Shopping.create_cart(valid_attrs)
      assert cart.owner == 42
    end

    test "create_cart/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shopping.create_cart(@invalid_attrs)
    end

    test "update_cart/2 with valid data updates the cart" do
      cart = cart_fixture()
      update_attrs = %{owner: 43}

      assert {:ok, %Cart{} = cart} = Shopping.update_cart(cart, update_attrs)
      assert cart.owner == 43
    end

    test "update_cart/2 with invalid data returns error changeset" do
      cart = cart_fixture()
      assert {:error, %Ecto.Changeset{}} = Shopping.update_cart(cart, @invalid_attrs)
      assert cart == Shopping.get_cart!(cart.id)
    end

    test "delete_cart/1 deletes the cart" do
      cart = cart_fixture()
      assert {:ok, %Cart{}} = Shopping.delete_cart(cart)
      assert_raise Ecto.NoResultsError, fn -> Shopping.get_cart!(cart.id) end
    end

    test "change_cart/1 returns a cart changeset" do
      cart = cart_fixture()
      assert %Ecto.Changeset{} = Shopping.change_cart(cart)
    end
  end
end
