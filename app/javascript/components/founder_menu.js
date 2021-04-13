const menuFounder = () => {
  const body = document.getElementsByTagName("body")[0];
  const insideMenu = document.getElementById("inside-menu-founder");
  const menu = document.getElementById("menu-founder");
  const className = "hidden";
  if (menu == undefined) return;
  body.addEventListener(
    "click",
    (evt) => {
      if (
        evt.target == menu ||
        evt.target == menu.firstElementChild.firstElementChild
      ) {
        if (insideMenu.classList.contains(className)) {
          insideMenu.classList.remove(className);
        } else {
          insideMenu.classList.add(className);
        }
      } else {
        insideMenu.classList.add(className);
      }
    },
    false
  );
};

export { menuFounder };
