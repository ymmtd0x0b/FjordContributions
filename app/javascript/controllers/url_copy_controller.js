import { Controller } from "@hotwired/stimulus";
import { switchingShowHidden } from "helpers/switching_show_hidden";

// Connects to data-controller="url-copy"
export default class extends Controller {
  static targets = [
    "defaultIcon",
    "successIcon",
    "defaultTooltipMessage",
    "successTooltipMessage",
  ];

  static values = {
    publicUrl: String,
  };

  run() {
    navigator.clipboard.writeText(this.publicUrlValue);

    switchingShowHidden(this.defaultIconTarget, this.successIconTarget);
    switchingShowHidden(
      this.defaultTooltipMessageTarget,
      this.successTooltipMessageTarget,
    );
  }
}
