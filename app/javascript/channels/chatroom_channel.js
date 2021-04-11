import consumer from "./consumer";

const initChatroomCable = (id) => {
  const messagesContainer = document.getElementById("messages");
  consumer.subscriptions.create(
    { channel: "ChatroomChannel", id: id },
    {
      received(data) {
        if (messagesContainer.dataset.chatroomId === data.chatroom_id) {
          messagesContainer.insertAdjacentHTML("beforeend", data.message);
          messagesContainer.scrollTo(0, messagesContainer.scrollHeight);
        }
      },
    }
  );
};

export { initChatroomCable };
