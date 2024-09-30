import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["modal", "dialog", "loading"];

  showLoading() {
    this.dialogTarget.classList.add("hidden");
    this.loadingTarget.classList.remove("hidden");
    this.modalTarget.classList.add("pointer-events-none");
  }
}
