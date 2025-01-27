defmodule BiltonglyWeb.BoxLive.FormComponent do
  use BiltonglyWeb, :live_component

  alias Biltongly.Biltong

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage box records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="box-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Box</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{box: box} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Biltong.change_box(box))
     end)}
  end

  @impl true
  def handle_event("validate", %{"box" => box_params}, socket) do
    changeset = Biltong.change_box(socket.assigns.box, box_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"box" => box_params}, socket) do
    save_box(socket, socket.assigns.action, box_params)
  end

  defp save_box(socket, :edit, box_params) do
    case Biltong.update_box(socket.assigns.box, box_params) do
      {:ok, box} ->
        notify_parent({:saved, box})

        {:noreply,
         socket
         |> put_flash(:info, "Box updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_box(socket, :new, box_params) do
    case Biltong.create_box(box_params) do
      {:ok, box} ->
        notify_parent({:saved, box})

        {:noreply,
         socket
         |> put_flash(:info, "Box created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
