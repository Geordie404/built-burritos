defmodule ChatWeb.RoomChannel do
  use ChatWeb, :channel

  @impl true
  def join("room:lobby", _payload, socket) do
      # send(self(), :after_join)
      {:ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  # @impl true
  # def handle_in("shout", payload, socket) do
  #   Chat.Message.changeset(%Chat.Message{}, payload) |> Chat.Repo.insert  # insert into repo
  #   broadcast(socket, "shout", payload)
  #   {:noreply, socket}
  # end

  @impl true
  def handle_in("shout-burrito", payload, socket) do
    Chat.Burrito.changeset(%Chat.Burrito{}, payload) |> Chat.Repo.insert  # insert into repo
    broadcast(socket, "shout-burrito", payload)
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

# def handle_info(:after_join, socket) do
#   Chat.Message.get_messages()
#   |> Enum.reverse() # revers to display the latest message at the bottom of the page
#   |> Enum.each(fn msg -> push(socket, "shout", %{
#       time: msg.time,
#       name: msg.name,
#       message: msg.message,
#     }) end)
#   {:noreply, socket} # :noreply
# end

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
      toppings: burrito.toppings
    }) end)
  {:noreply, socket} # :noreply
end

end
