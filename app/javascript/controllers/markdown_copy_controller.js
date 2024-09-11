import { Controller } from "@hotwired/stimulus"
import { NodeHtmlMarkdown } from 'node-html-markdown'

// Connects to data-controller="url-copy"
export default class extends Controller {
  static targets = [
    'defaultIcon',
    'successIcon',
    'defaultTooltipMessage',
    'successTooltipMessage'
  ]

  run() {
    const markdownText = NodeHtmlMarkdown.translate(
      document.getElementById('contributions-table').innerHTML,
      { bulletMarker: '-' }
    )
    navigator.clipboard.writeText(markdownText)

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
    }, 2000);
  }
}
