import { Controller } from '@hotwired/stimulus'
import switchingShowHidden from '../switching_show_hidden'

// Connects to data-controller="url-copy"
export default class extends Controller {
  static targets = [
    'defaultIcon',
    'successIcon',
    'defaultTooltipMessage',
    'successTooltipMessage'
  ]

  run() {
    navigator.clipboard.writeText(document.location.href)

    switchingShowHidden(this.defaultIconTarget, this.successIconTarget)
    switchingShowHidden(
      this.defaultTooltipMessageTarget,
      this.successTooltipMessageTarget
    )
  }
}
