import consumer from "./consumer"

// Assuming you have the chat_room_id available in your context
const chatRoomId = document.getElementById('chat-room-id').value; // Example to get the ID from an element

consumer.subscriptions.create(
  { channel: "ChatRoomChannel", chat_room_id: chatRoomId },
  {
    received(data) {
      // Logic to handle the received data
    }
  }
);
