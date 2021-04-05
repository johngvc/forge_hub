import { fetchWithToken } from "./fetch_with_token";

const updateChatroomMessages = (event) => {
  // Get new message button
  const roomId = document.getElementById("rooms").value;
  const messagesContainer = document.getElementById("messages"); //para data-chatroom-id

  fetchWithToken(`/api/v1/chatrooms/${roomId}`, {
    method: "GET",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
  })
    .then((response) => response.json())
    .then((data) => {
      messagesContainer.textContent = "";
      data.messages.forEach((message) => {
        let messageHTMLPartial = `
          <div class="message-container" id="message-${message.id}">
            <i class="author">
              <span>${message.user_name}</span>
              <small>${message.created_at}</small>
            </i>
            <p>${message.content}</p>
          </div>
          `;
        messagesContainer.insertAdjacentHTML("beforeend", messageHTMLPartial);
      });
    });
};

export { updateChatroomMessages };
