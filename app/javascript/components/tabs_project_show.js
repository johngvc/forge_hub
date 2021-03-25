const initOpenTab = (event, tab) => {
  // Get all clickable buttons
  const tabButtons = document.querySelectorAll(".btn-tab");
  tabButtons.forEach((element) => {
    element.addEventListener("click", (event) => {
      let tab = event.target.id;
      // Remove active from all buttons
      document.querySelectorAll(".btn-tab").forEach((element) => {
        element.classList.remove("active");
      });

      // Set the button pressed active
      event.currentTarget.classList.toggle("active");

      // Close all opened tabs
      const tabsContentElements = document.querySelectorAll(".tab-content");
      tabsContentElements.forEach((element) => {
        element.style.display = "none";
      });

      // Open the clicked tab
      const tabToOpen = document.getElementById(`content-${tab}`);
      tabToOpen.style.display = "block";
    });
  });
};

export { initOpenTab };
