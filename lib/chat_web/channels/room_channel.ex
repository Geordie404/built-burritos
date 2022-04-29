defmodule ChatWeb.RoomChannel do
  use ChatWeb, :channel

  @impl true
  def join("room:lobby", _payload, socket) do
      # send(self(), :after_join)
      {:ok, socket}
  end

  @impl true
  def handle_in("build-burrito", payload, socket) do
    Chat.Burrito.changeset(%Chat.Burrito{}, payload)
    |> Chat.Repo.insert #insert into repo
    |> case do # patern match the insertion tuple
      {:ok, _} ->
        Chat.Burrito.get_all_burritos(1)
        |> burrito_display("shout-burrito", socket)
      {:error,_} ->
        push(socket, "no-name", %{})

    end

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
    user_burritos =  Chat.Burrito.get_user_burritos(String.capitalize(user_name))

    # need to use list of users burritos in first arguement of burrito_display
    user_burritos
    |> case do
      [] -> push(socket, "no-burritos", %{})
       _ -> burrito_display(user_burritos, "shout-past-burritos", socket)
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
        # list of toppings that can easily be displayed
        toppings: burrito.toppings,
        calories: burrito.calories,
        protein_grams: burrito.protein_grams,
        price: burrito.price
      }) end)
  end

end
