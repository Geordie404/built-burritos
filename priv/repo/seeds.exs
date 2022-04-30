# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Chat.Repo.insert!(%Chat.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Chat.Repo.insert!(%Chat.Burrito{
    base: "salad",
    beans: "black",
    calories: 860,
    cheese: true,
    cilantro: true,
    date: "4/30/2022",
    extra: "x-steak",
    fajita: false,
    habanero: false,
    jalapeno: false,
    message: "This is the first seeded data",
    name: "Geordie",
    onion: false,
    pico: false,
    price: 14.5,
    protein: "chicken",
    protein_grams: 133,
    purchased: true,
    rice: "brown",
    time: "8:00:00 AM",
    toppings: "cheese, cilantro, jalapeno"
  })

Chat.Repo.insert!(%Chat.Burrito{
    base: "flour",
    beans: "black",
    calories: 650,
    cheese: false,
    cilantro: false,
    date: "4/30/2022",
    extra: "false",
    fajita: false,
    habanero: false,
    jalapeno: false,
    message: "This is the second seeded data",
    name: "Geordie",
    onion: false,
    pico: false,
    price: 9.0,
    protein: "beef",
    protein_grams: 59,
    purchased: true,
    rice: "white",
    time: "10:00:00 AM",
    toppings: "no toppings"
  })

  Chat.Repo.insert!(%Chat.Burrito{
      base: "salad",
      beans: "black",
      calories: 860,
      cheese: true,
      cilantro: true,
      date: "4/30/2022",
      extra: "x-steak",
      fajita: false,
      habanero: false,
      jalapeno: false,
      message: "last seed, i hope i get this job :)",
      name: "Geordie",
      onion: false,
      pico: false,
      price: 42.5,
      protein: "chicken",
      protein_grams: 133,
      purchased: true,
      rice: "brown",
      time: "11:00:00 AM",
      toppings: "its been a fun challenge"
    })
