import { csrfToken } from "@rails/ujs";

const fetchWithToken = (url, options) => {
  options.headers = {
    "X-CSRF-Token": csrfToken(),
    ...options.headers,
  };

  return fetch(url, options);
};

export { fetchWithToken };
