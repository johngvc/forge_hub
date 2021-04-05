import { fetchWithToken } from "./fetch_with_token";
import { updateChatroomMessages } from "./update_chatroom_messages";

const updateChatroomId = (event) => {
  // Get new message button
  const roomId = document.getElementById("rooms").value;
  const title = document.getElementById("chatroom-title");
  const messagesContainer = document.getElementById("messages"); //para data-chatroom-id
  messagesContainer.dataset.chatroomId = roomId; // Setar Room ID

  fetchWithToken(`/api/v1/chatrooms/${roomId}`, {
    method: "GET",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
  })
    .then((response) => response.json())
    .then((data) => {
      title.textContent = "";
      title.insertAdjacentHTML("beforeend", data.room.name);
      updateChatroomMessages();
    });
};

export { updateChatroomId };
