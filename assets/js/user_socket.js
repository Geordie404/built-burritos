
// Bring in Phoenix channels client library:
import {Socket} from "phoenix"

// And connect to the path in "lib/chat_web/endpoint.ex". We pass the
// token for authentication. Read below how it should be used.
let socket = new Socket("/socket", {params: {token: window.userToken}})

// Finally, connect to the socket:
socket.connect()

// Now that you are connected, you can join channels with a topic.
// Let's assume you have a channel with a topic named `room` and the
// subtopic is its id - in this case 42:
let channel = socket.channel("room:lobby", {})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

// creates a string out of the checked boxes

let build_burrito = document.getElementById('build-button'); //finalize burrito button
build_burrito.addEventListener('click', function (event) {
  build_burrito.value = "Update Order";
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

  // creates a string with all selected toppings

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


    channel.push('build-burrito',
    { //send the message to the server on "shout" channel
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

// purchase button functionality
let purchase_burrito = document.getElementById('purchase-button'); //show past burritos
purchase_burrito.addEventListener('click', function (event) {
  let ul = document.getElementById('msg-list');
  channel.push('purchase-burrito', name);
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
   let purchase_burrito = document.getElementById('purchase-button')
   purchase_burrito.style.display = "none";
   build_burrito.value = "New Burrito"
  });

// shout for current burrito build
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
  + " created on " + payload.date + " at " + payload.time

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

// shout to show past burritos
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

  msg.value = "";
});


// some channel events for updating the UI

channel.on('no-burritos', function() {
  let ul = document.getElementById('msg-list');
  let order_details = document.createElement("li");
  order_details.innerHTML = "no past orders from this user"
  ul.appendChild(order_details);
  let purchase_burrito = document.getElementById('purchase-button')
  purchase_burrito.style.display = "none";
});

channel.on('no-name', function() {
  let ul = document.getElementById('msg-list');
  ul.innerHTML = "";
  let order_details = document.createElement("li");
  ul.appendChild(order_details);
  let purchase_burrito = document.getElementById('purchase-button')
  purchase_burrito.style.display = "none";
});

channel.on('purchasable', function() {
  let purchase_burrito = document.getElementById('purchase-button')
  purchase_burrito.style.display = "block";
});

channel.on('purchase', function(payload) {
  let ul = document.getElementById('msg-list');
  let order_details = document.createElement("li");
  let purchase_burrito = document.getElementById('purchase-button')
  purchase_burrito.style.display = "none";
  order_details.innerHTML = "Thank you for your $" + payload.price + " purchase " + payload.name + "!";
  ul.appendChild(order_details);
  build_burrito.value = "New Burrito"
  msg.value = "";
});

export default socket
