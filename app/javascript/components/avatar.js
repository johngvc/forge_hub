const resizeProfileAvatar = () =>{
  //force height = width
  let avatar = document.getElementsByClassName('avatar-big')[0];
  if(avatar == undefined) return;
  let forceHeight = parseFloat(window.getComputedStyle(avatar, null).width);
  avatar.style.height = `${forceHeight}px`;
}

export { resizeProfileAvatar }