import { Controller } from '@hotwired/stimulus'
import { NodeHtmlMarkdown } from 'node-html-markdown'
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
    const markdownText = NodeHtmlMarkdown.translate(
      document.getElementById('contributions-table').innerHTML,
      { bulletMarker: '-' }
    )
    navigator.clipboard.writeText(markdownText)

    switchingShowHidden(this.defaultIconTarget, this.successIconTarget)
    switchingShowHidden(
      this.defaultTooltipMessageTarget,
      this.successTooltipMessageTarget
    )
  }
}
