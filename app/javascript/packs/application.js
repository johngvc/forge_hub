// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import { initModal } from "../components/modal";
import { msgModal } from "../components/modal_messages";
import { changeRoleModal } from "../components/modal_change_role";
import "bootstrap";
import "jquery";
import { event } from "jquery";
import { initOpenTab } from "../components/tabs_project_show";
import { map } from "../components/footer_map";
import Rellax from "rellax";
import { zIndexOnScroll } from "../components/project_header";
import { getVPHeight } from "../components/project_header";
import { readMore } from "../components/project_header";
import { menuFounder } from "../components/founder_menu";

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
require("trix");
require("@rails/actiontext");

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

document.addEventListener("turbolinks:load", () => {
  // Call your functions here, e.g:
  // initSelect2();
  initModal();
  msgModal();
  initOpenTab();
  //changeRoleModal();
  map();

  //init rellax
  let rellax = new Rellax(".rellax");

  //projects show
  let height = getVPHeight();
  readMore(height);
  menuFounder();
  window.addEventListener(
    "scroll",
    function () {
      zIndexOnScroll(height);
    },
    false
  );
});

require("trix");
require("@rails/actiontext");
