import { fetchWithToken } from "../components/fetch_with_token";

const ajaxNewMessageCall = (event) => {
  // Get new message button
  const newMessageButton = document.getElementById("new-message-btn");

  newMessageButton.addEventListener("click", (event) => {
    const data = {
      messageContent: document.getElementById("new-message-input").value,
      activeChatRoomId: document.getElementById("messages").dataset.chatroomId,
    };
    fetchWithToken("/message", {
      method: "POST",
      headers: {
        Accept: "text/html",
        "Content-Type": "application/json",
      },
      body: JSON.stringify(data),
    });
  });
};

export { ajaxNewMessageCall };
