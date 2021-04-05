import { updateChatroomId } from "../components/update_chatroom_id";

const initUpdateChatroomEvent = (event) => {
  // Get new message button
  const comboBoxElement = document.getElementById("rooms");

  if (comboBoxElement != undefined) {
    comboBoxElement.addEventListener("change", (event) => {
      updateChatroomId();
    });
  }
};

export { initUpdateChatroomEvent };
