import { fetchWithToken } from "./fetch_with_token";
import { getCookie } from "../components/get_cookie";

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

// Code by lvoelk start with some modifications, available at
// <https://stackoverflow.com/questions/11821261/how-to-get-all-selected-values-from-select-multiple-multiple>
const getSelectValues = (select) => {
  let result = {};
  const options = select && select.options;
  let opt;

  for (let i = 0, iLen = options.length; i < iLen; i++) {
    opt = options[i];

    if (opt.selected) {
      result[opt.value] = opt.text;
    }
  }
  return result;
};
// Code by lvoelk end

const initNewChatroomEventListener = () => {
  const newChatroomButton = document.querySelector(
    ".chatroom-box-title-and-new-message i"
  );
  const usersSelectElement = document.querySelector(
    "#chatroom-box .form-select"
  );

  newChatroomButton.addEventListener("click", () => {
    let chatroomName = "";
    let chatroomUsersId = [];
    let selectedUsers = getSelectValues(usersSelectElement);
    const currentUserId = parseInt(getCookie("user_id"), 10);

    chatroomUsersId.push(currentUserId);
    Object.keys(selectedUsers).forEach((key) => {
      chatroomName = `${chatroomName}, ${selectedUsers[key]}`;
      chatroomUsersId.push(key);
    });
    debugger;
    ajaxNewChatroomCall(chatroomName, chatroomUsersId);
  });
};

const updateUsersSelectElement = () => {
  const usersSelectElement = document.querySelector(
    "#chatroom-box .form-select"
  );

  fetchWithToken(`/api/v1/users`, {
    method: "GET",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
  })
    .then((response) => response.json())
    .then((data) => {
      const currentUserId = parseInt(getCookie("user_id"), 10);

      usersSelectElement.textContent = "";
      data.forEach((user) => {
        if (user.id != currentUserId) {
          usersSelectElement.insertAdjacentHTML(
            "beforeend",
            `<option value="${user.id}">${user.name}</option>`
          );
        }
      });
    });
};

export { updateUsersSelectElement };
export { initNewChatroomEventListener };
