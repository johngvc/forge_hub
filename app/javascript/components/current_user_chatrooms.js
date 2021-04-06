import { fetchWithToken } from "../components/fetch_with_token";
import { getCookie } from "../components/get_cookie";
import { updateChatroomId } from "../components/update_chatroom_id";
import { initChatroomCable } from "../channels/chatroom_channel";

const initCurrentUserChatrooms = (event) => {
  // Get combo box input with the room selected
  const chatRoomsContainer = document.getElementById("chatrooms");
  const currentUserId = parseInt(getCookie("user_id"), 10);
  fetchWithToken(`/api/v1/chatrooms/user_chatrooms/${currentUserId}`, {
    method: "GET",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
  })
    .then((response) => response.json())
    .then((data) => {
      data.forEach((element) => {
        const chatroom_element = `<div class="single-chatroom" data-room-id="${element.id}">
          <div class="chatroom-photo"></div>
          <div class="chatroom-desc">
            ${element.name}
          </div>
        </div>`;

        chatRoomsContainer.insertAdjacentHTML("beforeend", chatroom_element);

        const chatroomElements = document.querySelectorAll(".single-chatroom");

        chatroomElements.forEach((chatRoom) => {
          chatRoom.addEventListener("click", (event) => {
            console.log("change chatroom");
            chatroomElements.forEach((chatRoomInnerLoop) => {
              chatRoomInnerLoop.classList.remove("active");
            });
            event.currentTarget.classList.toggle("active");
            updateChatroomId();
          });
        });
        initChatroomCable(element.id);
      });
      updateChatroomId();
    });
};

export { initCurrentUserChatrooms };
