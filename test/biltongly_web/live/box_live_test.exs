defmodule BiltonglyWeb.BoxLiveTest do
  use BiltonglyWeb.ConnCase

  import Phoenix.LiveViewTest
  import Biltongly.BiltongFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_box(_) do
    box = box_fixture()
    %{box: box}
  end

  describe "Index" do
    setup [:create_box]

    test "lists all boxes", %{conn: conn, box: box} do
      {:ok, _index_live, html} = live(conn, ~p"/boxes")

      assert html =~ "Listing Boxes"
      assert html =~ box.name
    end

    test "saves new box", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/boxes")

      assert index_live |> element("a", "New Box") |> render_click() =~
               "New Box"

      assert_patch(index_live, ~p"/boxes/new")

      assert index_live
             |> form("#box-form", box: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#box-form", box: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/boxes")

      html = render(index_live)
      assert html =~ "Box created successfully"
      assert html =~ "some name"
    end

    test "updates box in listing", %{conn: conn, box: box} do
      {:ok, index_live, _html} = live(conn, ~p"/boxes")

      assert index_live |> element("#boxes-#{box.id} a", "Edit") |> render_click() =~
               "Edit Box"

      assert_patch(index_live, ~p"/boxes/#{box}/edit")

      assert index_live
             |> form("#box-form", box: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#box-form", box: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/boxes")

      html = render(index_live)
      assert html =~ "Box updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes box in listing", %{conn: conn, box: box} do
      {:ok, index_live, _html} = live(conn, ~p"/boxes")

      assert index_live |> element("#boxes-#{box.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#boxes-#{box.id}")
    end
  end

  describe "Show" do
    setup [:create_box]

    test "displays box", %{conn: conn, box: box} do
      {:ok, _show_live, html} = live(conn, ~p"/boxes/#{box}")

      assert html =~ "Show Box"
      assert html =~ box.name
    end

    test "updates box within modal", %{conn: conn, box: box} do
      {:ok, show_live, _html} = live(conn, ~p"/boxes/#{box}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Box"

      assert_patch(show_live, ~p"/boxes/#{box}/show/edit")

      assert show_live
             |> form("#box-form", box: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#box-form", box: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/boxes/#{box}")

      html = render(show_live)
      assert html =~ "Box updated successfully"
      assert html =~ "some updated name"
    end
  end
end
