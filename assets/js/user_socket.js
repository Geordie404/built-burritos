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

// code for chat room window

// channel.on('shout', function (payload) { // listen to the 'shout' event
//   let li = document.createElement("li"); // create new list item DOM element
//   let today = new Date();
//   let time = today.getHours() + ":" + today.getMinutes();
//   let name = payload.name || 'guest';    // get name from payload or set default
//   li.innerHTML = '<span id="time">' + '[ ' + time + ' ] ' + '</span>' + '<b>' + name + '</b>: ' + payload.message + '\n'; // set li contents
//   ul.appendChild(li);                    // append to list
//   ul.lastChild.scrollIntoView()
// });


channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

// let ul = document.getElementById('msg-list');        // list of messages.
// let today = new Date();
// let time = today.getHours() + ":" + today.getMinutes(); // time message sent
// let name = document.getElementById('name');          // name of message sender
// let msg = document.getElementById('msg');            // message input field

// msg.addEventListener('keypress', function (event) {
//   if (event.keyCode == 13 && msg.value.length > 0) { // don't sent empty msg.
//     channel.push('shout', { // send the message to the server on "shout" channel
//       time: time,
//       name: name.value || "guest",     // get value of "name" of person sending the message. Set guest as default
//       message: msg.value    // get message text (value) from msg input field.
//     });
//     msg.value = '';         // reset the message input field for next message.
//   }
// });

// code for burrito maker





// Finalize burrito button

let build = document.getElementById('finalize-button'); //finalize burrito button
build.addEventListener('click', function (event) {
  console.log("built burrito");

  let name = document.getElementById('name');          // name of message sender
  let msg = document.getElementById('msg');
  let today = new Date();

  // data from selects

  let burrito_base = document.getElementById('base-options')
  let burrito_protein = document.getElementById('protein-options')
  let burrito_protein_extra = document.getElementById('protein-seconds')
  let burrito_rice = document.getElementById('rice-options')
  let burrito_beans = document.getElementById('beans-options')
  let protien_price = document.getElementById('cost-1')
  let protien_price_extra = document.getElementById('cost-2')

  // data from checkboxes

  let burrito_topping_cheese = document.getElementById('cheese-checkbox').checked
  let burrito_topping_cilantro = document.getElementById('cilantro-checkbox').checked
  let burrito_topping_onion = document.getElementById('onion-checkbox').checked
  let burrito_topping_jalapeno = document.getElementById('jalapeno-checkbox').checked
  let burrito_topping_fajita = document.getElementById('fajita-checkbox').checked
  let burrito_topping_salsa = document.getElementById('salsa-checkbox').checked
  let burrito_topping_habanero = document.getElementById('habanero-checkbox').checked
  let burrito_topping_pico = document.getElementById('pico-checkbox').checked
  // let protein_cost = parseInt(burrito_protein.price) + parseInt(burrito_protein_2.price)


    channel.push('shout-burrito', { // send the message to the server on "shout" channel
      burrito: true,
      time: today,
      name: name.value || "guest",     // get value of "name" of person sending the message. Set guest as default
      message:msg.value || "no extra instructions",  // get message text (value) from msg input field.
      // ingredient fields
      base: burrito_base.value,
      protein: burrito_protein.value,
      extra: burrito_protein_extra.value,
      rice: burrito_rice.value,
      beans: burrito_beans.value
      // toppings fields
      

    });
    msg.value = '';         // reset the message input field for next message.

    // let ul = document.getElementById('msg-list');
});

//shows past orders
let past_orders = document.getElementById('past-button'); //show past burritos
past_orders.addEventListener('click', function (event) {
  let ul = document.getElementById('msg-list');
  ul.innerHTML = "";
  channel.push('past-orders');
 });


// shout code for burrito

channel.on('shout-burrito', function (payload) { // listen to the 'shout' event
  let ul = document.getElementById('msg-list');
  ul.innerHTML = "";
  let order_details = document.createElement("li"); // create new list item DOM element
  let burrito_details = document.createElement("li");
  let additional_instructions = document.createElement("li");
  // let today = new Date();
  // let time = today.getHours() + ":" + today.getMinutes();
  // let name = payload.name || 'guest';    // get name from payload or set default

  order_details.innerHTML = '<b>' + payload.name + "'s burrito" + '</b>' + ' | ' + "order time: " + '<span id="time">' + payload.time + '</span>'
  burrito_details.innerHTML =
  "ingredients | " + "base: " + payload.base + ", proteins: " + payload.protein + ", extra protein: " + payload.extra
  + ", rice: " + payload.rice + ", beans: " + payload.beans
  additional_instructions.innerHTML = "additional instructions: " + payload.message

  ul.appendChild(order_details);
  ul.appendChild(burrito_details);
  ul.appendChild(additional_instructions);

});

channel.on('shout-past-burritos', function (payload) { // listen to the 'shout' event
  let ul = document.getElementById('msg-list');
  let order_details = document.createElement("li"); // create new list item DOM element
  let burrito_details = document.createElement("li");

  // let today = new Date();
  // let time = today.getHours() + ":" + today.getMinutes();
  // let name = payload.name || 'guest';    // get name from payload or set default
  order_details.innerHTML = '<b>' + payload.name + "'s burrito" + '</b>' + ' | ' + "order time: " + '<span id="time">' + payload.time + '</span>'
  + "| ingredients: " + payload.base + ", " + payload.protein + ", " + payload.extra + ", " + payload.rice + ", " + payload.beans

  ul.appendChild(order_details);

});

export default socket
