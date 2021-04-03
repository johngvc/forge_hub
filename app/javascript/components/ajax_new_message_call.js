import { fetchWithToken } from "../components/fetch_with_token";

const ajaxNewMessageCall = (event) => {
  // Get new message button
  const newMessageButton = document.getElementById("new-message-btn");
  newMessageButton.addEventListener("click", (event) => {
    fetchWithToken("/message", {
      method: "POST",
      headers: {
        Accept: "text/html",
        "Content-Type": "text/html",
      },
    });
  });
};

export { ajaxNewMessageCall };
