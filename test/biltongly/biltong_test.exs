defmodule Biltongly.BiltongTest do
  use Biltongly.DataCase

  alias Biltongly.Biltong

  describe "boxes" do
    alias Biltongly.Biltong.Box

    import Biltongly.BiltongFixtures

    @invalid_attrs %{name: nil}

    test "list_boxes/0 returns all boxes" do
      box = box_fixture()
      assert Biltong.list_boxes() == [box]
    end

    test "get_box!/1 returns the box with given id" do
      box = box_fixture()
      assert Biltong.get_box!(box.id) == box
    end

    test "create_box/1 with valid data creates a box" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Box{} = box} = Biltong.create_box(valid_attrs)
      assert box.name == "some name"
    end

    test "create_box/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Biltong.create_box(@invalid_attrs)
    end

    test "update_box/2 with valid data updates the box" do
      box = box_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Box{} = box} = Biltong.update_box(box, update_attrs)
      assert box.name == "some updated name"
    end

    test "update_box/2 with invalid data returns error changeset" do
      box = box_fixture()
      assert {:error, %Ecto.Changeset{}} = Biltong.update_box(box, @invalid_attrs)
      assert box == Biltong.get_box!(box.id)
    end

    test "delete_box/1 deletes the box" do
      box = box_fixture()
      assert {:ok, %Box{}} = Biltong.delete_box(box)
      assert_raise Ecto.NoResultsError, fn -> Biltong.get_box!(box.id) end
    end

    test "change_box/1 returns a box changeset" do
      box = box_fixture()
      assert %Ecto.Changeset{} = Biltong.change_box(box)
    end
  end
end
