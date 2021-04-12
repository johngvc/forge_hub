const menuFounder = () => {
  const body = document.getElementsByTagName("body")[0];
  const insideMenu = document.getElementById("inside-menu-founder");
  const menu = document.getElementById("menu-founder");
  if (menu == undefined) return;
  body.addEventListener(
    "click",
    (evt) => {
      if (
        evt.target == menu ||
        evt.target == menu.firstElementChild.firstElementChild
      ) {
        insideMenu.classList.remove("hidden");
      } else {
        insideMenu.classList.add("hidden");
      }
    },
    false
  );
};

export { menuFounder };
