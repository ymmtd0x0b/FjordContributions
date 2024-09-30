export const switchingShowHidden = (showEl, hideEl) => {
  showEl.classList.add("hidden");
  hideEl.classList.remove("hidden");

  // reset to default state
  setTimeout(() => {
    showEl.classList.remove("hidden");
    hideEl.classList.add("hidden");
  }, 2000);
};
