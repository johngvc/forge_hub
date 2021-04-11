import { fetchWithToken } from "./fetch_with_token";

const ajaxNewChatroomCall = (chatroomName, participantsIds) => {
  const data = {
    chatRoomName: chatroomName,
    participants_ids: participantsIds,
  };
  fetchWithToken("/chatroom", {
    method: "POST",
    headers: {
      Accept: "text/html",
      "Content-Type": "application/json",
    },
    body: JSON.stringify(data),
  });
};

export { ajaxNewChatroomCall };
