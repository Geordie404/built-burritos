// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// Bring in Phoenix channels client library:
import {Socket} from "phoenix"

// And connect to the path in "lib/chat_web/endpoint.ex". We pass the
// token for authentication. Read below how it should be used.
let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/chat_web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/chat_web/templates/layout/app.html.heex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/3" function
// in "lib/chat_web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket, _connect_info) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1_209_600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, connect to the socket:
socket.connect()

// Now that you are connected, you can join channels with a topic.
// Let's assume you have a channel with a topic named `room` and the
// subtopic is its id - in this case 42:
let channel = socket.channel("room:lobby", {})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

// Finalize burrito button

let build = document.getElementById('finalize-button'); //finalize burrito button
build.addEventListener('click', function (event) {

  let name = document.getElementById('name');          // name of message sender
  let msg = document.getElementById('msg');
  let today = new Date();
  let time = today.toLocaleTimeString();
  let date = today.toLocaleDateString();


  // data from selects

  let burrito_base = document.getElementById('base-options')
  let burrito_protein = document.getElementById('protein-options')
  let burrito_protein_extra = document.getElementById('protein-seconds')
  let burrito_rice = document.getElementById('rice-options')
  let burrito_beans = document.getElementById('beans-options')
  let protien_price = document.getElementById('cost-1')
  let protien_price_extra = document.getElementById('cost-2')

  // data from checkboxes

  let topping_cheese = document.getElementById('cheese-checkbox')
  let topping_cilantro = document.getElementById('cilantro-checkbox')
  let topping_onion = document.getElementById('onion-checkbox')
  let topping_jalapeno = document.getElementById('jalapeno-checkbox')
  let topping_fajita = document.getElementById('fajita-checkbox')
  let topping_salsa = document.getElementById('salsa-checkbox')
  let topping_habanero = document.getElementById('habanero-checkbox')
  let topping_pico = document.getElementById('pico-checkbox')


  // creates a string out of the checked boxes
  var toppings_list = "none"
  if (topping_cheese.checked) {toppings_list = toppings_list.concat(", ", topping_cheese.value)}
  if (topping_cilantro.checked) {toppings_list = toppings_list.concat(", ", topping_cilantro.value)}
  if (topping_onion.checked) {toppings_list = toppings_list.concat(", ", topping_onion.value)}
  if (topping_jalapeno.checked) {toppings_list = toppings_list.concat(", ", topping_jalapeno.value)}
  if (topping_fajita.checked) {toppings_list = toppings_list.concat(", ", topping_fajita.value)}
  if (topping_salsa.checked) {toppings_list = toppings_list.concat(", ", topping_salsa.value)}
  if (topping_habanero.checked) {toppings_list = toppings_list.concat(", ", topping_habanero.value)}
  if (topping_pico.checked) {toppings_list = toppings_list.concat(", ", topping_pico.value)}
  if (toppings_list.length > 4) { toppings_list = toppings_list.slice(6)}
  if (toppings_list == "none") { toppings_list = "no toppings"}


    channel.push('build-burrito', { // send the message to the server on "shout" channel
      burrito: true,
      time: time,
      date: date,
      name: name.value,     // get value of "name" of person sending the message. Set guest as default
      message:msg.value || "no extra instructions",  // get message text (value) from msg input field.
      // ingredient fields
      base: burrito_base.value,
      protein: burrito_protein.value,
      extra: burrito_protein_extra.value,
      rice: burrito_rice.value,
      beans: burrito_beans.value,
      // toppings fields
      cheese: topping_cheese.checked,
      cilantro: topping_cilantro.checked,
      onion: topping_onion.checked,
      jalapeno: topping_jalapeno.checked,
      fajita: topping_fajita.checked,
      salsa: topping_salsa.checked,
      habanero: topping_habanero.checked,
      pico: topping_pico.checked,
      // list of all toppings
      toppings: toppings_list,
      calories: 0,
      purchased: false
    });

    // let ul = document.getElementById('msg-list');
});

//shows all past orders
let past_orders = document.getElementById('past-button'); //show past burritos
past_orders.addEventListener('click', function (event) {
  let ul = document.getElementById('msg-list');
  ul.innerHTML = "";
  channel.push('past-orders');
 });

 //shows users past orders
 let users_orders = document.getElementById('name-filter-button'); //show past burritos
 users_orders.addEventListener('click', function (event) {
   let name = document.getElementById('name').value || "";
   let ul = document.getElementById('msg-list');
   if (name.length > 0) {
     ul.innerHTML = name + "'s past orders";
     channel.push('named-orders', name);
   }
   else {
     ul.innerHTML = "no name entered";
   }

  });

// shout for burrito

channel.on('shout-burrito', function (payload) { // listen to the 'shout' event
  let ul = document.getElementById('msg-list');
  ul.innerHTML = "";
  let order_details = document.createElement("li"); // create new list item DOM element
  let burrito_ingredients = document.createElement("li");
  let burrito_toppings = document.createElement("li");
  let additional_instructions = document.createElement("li");
  let burrito_nutrition = document.createElement("li");
  let burrito_price = document.createElement("li");

  let extra = payload.extra;
  if (extra == "false") {extra = "no extra"} else {extra = extra.slice(2)};

  order_details.innerHTML = '<b>' + payload.name + "'s " + payload.protein + " burrito" + '</b>'
  + " ordered on " + payload.date + " at " + payload.time

  burrito_ingredients.innerHTML =
  "burrito " + "base: " + payload.base + ", protein: " + payload.protein + ", extra-protein: " + extra
  + ", rice: " + payload.rice + ", beans: " + payload.beans

  burrito_toppings.innerHTML = "toppings : " + payload.toppings
  additional_instructions.innerHTML = "additional notes: " + payload.message
  burrito_nutrition.innerHTML = '<b>' + "burrito macros: " + payload.calories + " calories, " + payload.protein_grams + " grams protein" + '</b>'
  burrito_price.innerHTML = '<b>' + "burrito Price: $" + payload.price + '</b>'

  ul.appendChild(order_details);
  ul.appendChild(burrito_ingredients);
  ul.appendChild(burrito_toppings);
  ul.appendChild(additional_instructions);
  ul.appendChild(burrito_nutrition);
  ul.appendChild(burrito_price);
});

channel.on('shout-past-burritos', function (payload) { // listen to the 'shout' event
  let ul = document.getElementById('msg-list');
  let order_details = document.createElement("li"); // create new list item DOM element
  let burrito_details = document.createElement("li");
  let extra = payload.extra;
  if (extra == "false") {extra = "no extra"} else {extra = extra.slice(2)};

  order_details.innerHTML = '<b>' + payload.name + "'s burrito" + '</b>' + " ordered on " + payload.date + " at " + payload.time
   + '<b>' + " for $" + payload.price + '</b>'

  burrito_details.innerHTML = "burrito base: " + payload.base + ", " + payload.protein + ", " + extra + ", " + payload.rice + ", " + payload.beans
  + " | toppings: " + payload.toppings + " | macros: " + payload.calories
  + "kcal, " + payload.protein_grams + "g protein"

  ul.appendChild(order_details);
  ul.appendChild(burrito_details);
});

channel.on('no-burritos', function() { // listen to the 'shout' event
  let ul = document.getElementById('msg-list');
  let order_details = document.createElement("li"); // create new list item DOM element
  order_details.innerHTML = "no past orders from this user"
  ul.appendChild(order_details);
});

channel.on('no-name', function() { // listen to the 'shout' event
  let ul = document.getElementById('msg-list');
  ul.innerHTML = "";
  let order_details = document.createElement("li"); // create new list item DOM element
  order_details.innerHTML = "enter your name before you build a burrito"
  ul.appendChild(order_details);
});



export default socket
