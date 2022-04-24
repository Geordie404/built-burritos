defmodule ChatWeb.RoomChannel do
  use ChatWeb, :channel

  @impl true
  def join("room:lobby", _payload, socket) do
      send(self(), :after_join)
      {:ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    Chat.Message.changeset(%Chat.Message{}, payload) |> Chat.Repo.insert  # insert into repo
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  # getting messages from the database to display

#   def handle_info(:after_join, socket) do
#   Chat.Message.get_messages()
#   # |> Enum.reverse() # revers to display the latest message at the bottom of the page
#   |> Enum.each(fn msg -> push(socket, "shout", %{
#       time: msg.time,
#       name: msg.name,
#       message: msg.message,
#     }) end)
#   {:noreply, socket} # :noreply
# end

end
