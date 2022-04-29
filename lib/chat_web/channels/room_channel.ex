defmodule ChatWeb.RoomChannel do
  use ChatWeb, :channel

  @impl true
  def join("room:lobby", _payload, socket) do
      # send(self(), :after_join)
      {:ok, socket}
  end

  @impl true
  def handle_in("shout-burrito", payload, socket) do
    Chat.Burrito.changeset(%Chat.Burrito{}, payload) |> Chat.Repo.insert  # insert into repo
    Chat.Burrito.get_all_burritos(1)
    |> burrito_display("shout-burrito", socket)
    {:noreply, socket}
  end

  @impl true
  def handle_in("past-orders", _payload, socket) do
    Chat.Burrito.get_all_burritos()
    |> burrito_display("shout-past-burritos", socket)
    {:noreply, socket}
  end


  @impl true
  def handle_in("named-orders", user_name, socket) do
    user_burritos = Chat.Burrito.get_user_burritos(user_name)
    user_burritos |> burrito_display("shout-past-burritos", socket)

    # if the there are no burritos from the user
    if (user_burritos == []) do
      push(socket, "no-burritos", %{})
    end

    {:noreply, socket}
  end

  defp burrito_display(burritos, shout, socket) do
    burritos
    |> Enum.each(fn burrito -> push(socket, shout, %{
        time: burrito.time,
        date: burrito.date,
        name: burrito.name,
        message: burrito.message,
        # ingredients
        base: burrito.base,
        protein: burrito.protein,
        extra: burrito.extra,
        rice: burrito.rice,
        beans: burrito.beans,
        toppings: burrito.toppings,
        calories: burrito.calories,
        protein_grams: burrito.protein_grams,
        price: burrito.price
      }) end)
  end


  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).

  # getting messages from the database to display

end
