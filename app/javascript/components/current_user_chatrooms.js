import { fetchWithToken } from "../components/fetch_with_token";
import { getCookie } from "../components/get_cookie";
import { updateChatroomId } from "../components/update_chatroom_id";

const initCurrentUserChatrooms = (event) => {
  // Get combo box input with the room selected
  const comboBoxElement = document.getElementById("rooms");
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
        const comboBoxOption = `<option value="${element.id}">${element.name}</option>`;
        comboBoxElement.insertAdjacentHTML("beforeend", comboBoxOption);
      });
      updateChatroomId();
    });
};

export { initCurrentUserChatrooms };
