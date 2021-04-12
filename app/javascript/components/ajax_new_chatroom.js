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
    "#chatroom-box form-select"
  );

  newChatroomButton.addEventListener("click", () => {
    let chatroomName = "";
    let chatroomUsersId = [];
    let selectedUsers = getSelectValues(usersSelectElement);

    selectedUsers.forEach((key, value) => {
      chatroomName = `${chatroomName}, ${value}`;
      chatroomUsersId.push(value);
    });
    ajaxNewChatroomCall(chatroomName, chatroomUsersId);
  });
};

const updateUsersSelectElement = () => {
  const usersSelectElement = document.querySelector(
    "#chatroom-box form-select"
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
      usersSelectElement.textContent = "";
      data.forEach((user) => {
        usersSelectElement.insertAdjacentHTML(
          "beforeend",
          `<option value="${user.id}">${user.name}</option>`
        );
      });
    });
};

export { updateUsersSelectElement };

export { initNewChatroomEventListener };
