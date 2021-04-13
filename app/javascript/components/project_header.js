const getVPHeight = () => {
  //get viewport height
  let h = Math.max(
    document.documentElement.clientHeight,
    window.innerHeight || 0
  );

  return h;
};

const zIndexOnScroll = (height) => {
  //get element do modify zIndex
  let header = document.getElementById("sh-prj-pg-header");

  if (header == undefined) return;

  //set scroll distance (vh)
  let h = (height / 100) * 5;

  if (document.body.scrollTop > h || document.documentElement.scrollTop > h) {
    header.style.zIndex = "-10";
  } else {
    header.style.zIndex = "1";
  }
};

const readMore = (height) => {
  //get button to scroll down
  const button = document.getElementById("read-more");
  if (button == undefined) return;

  //get height in vh
  let h = height * 0.9;

  const scroll = (height) => {
    document.body.scrollTop = height;
    document.documentElement.scrollTop = height;
  };

  button.addEventListener(
    "click",
    function () {
      scroll(h);
    },
    false
  );
};

export { getVPHeight };
export { zIndexOnScroll };
export { readMore };
