import { Controller } from "@hotwired/stimulus"

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

    const showSuccess = ($defaultEl, $successEl, cssClasses) => {
      $defaultEl.classList.add('hidden')
      $successEl.classList.remove(...cssClasses)
    }

    const resetToDefault = ($defaultEl, $successEl, cssClasses) => {
      $defaultEl.classList.remove(...cssClasses)
      $successEl.classList.add('hidden')
    }

    showSuccess(this.defaultIconTarget, this.successIconTarget, ['hidden','inline-flex','items-center'])
    showSuccess(this.defaultTooltipMessageTarget, this.successTooltipMessageTarget, ['hidden'])

    // reset to default state
    setTimeout(() => {
      resetToDefault(this.defaultIconTarget, this.successIconTarget, ['hidden','inline-flex','items-center'])
      resetToDefault(this.defaultTooltipMessageTarget, this.successTooltipMessageTarget, ['hidden'])
    }, 2000)
  }
}
