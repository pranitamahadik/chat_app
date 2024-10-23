// This JavaScript (message_channel.js) should run on the chat room page
import consumer from "channels/consumer";

consumer.subscriptions.create({ channel: "MessagesChannel", chat_room_id: chatRoomId }, {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to the MessagesChannel!");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Display the received message in the chat UI
    const messagesContainer = document.getElementById('messages');
    if (messagesContainer) {
      messagesContainer.insertAdjacentHTML('beforeend', `<p>${data.user}: ${data.content}</p>`);
    }
  }
});
