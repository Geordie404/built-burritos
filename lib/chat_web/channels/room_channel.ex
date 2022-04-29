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
    send(self(), :current_burrito)
    {:noreply, socket}
  end

  @impl true
  def handle_in("past-orders", _payload, socket) do
    send(self(), :past_burritos)
    {:noreply, socket}
  end

  @impl true
  def handle_in("past-orders", _payload, socket) do
    send(self(), :past_burritos)
    {:noreply, socket}
  end


  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).

  # getting messages from the database to display

# populate the li when join channel

@impl true
def handle_info(:past_burritos, socket) do
  Chat.Burrito.get_burritos()
  # |> Enum.reverse() # revers to display the latest message at the bottom of the page
  |> Enum.each(fn burrito -> push(socket, "shout-past-burritos", %{
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
  {:noreply, socket} # :noreply
end

@impl true
def handle_info(:current_burrito, socket) do
  Chat.Burrito.get_burritos(1)
  |> Enum.each(fn burrito -> push(socket, "shout-burrito", %{
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
  {:noreply, socket} # :noreply
end

end
