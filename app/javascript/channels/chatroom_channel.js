import consumer from "./consumer";

const initChatroomCable = (id) => {
  const messagesContainer = document.getElementById("messages");
  consumer.subscriptions.create(
    { channel: "ChatroomChannel", id: id },
    {
      received(data) {
        messagesContainer.insertAdjacentHTML("beforeend", data);
        messagesContainer.scrollTo(0, messagesContainer.scrollHeight);
      },
    }
  );
};

export { initChatroomCable };
