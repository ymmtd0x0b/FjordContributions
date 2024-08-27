import { Controller } from '@hotwired/stimulus'
import { NodeHtmlMarkdown } from 'node-html-markdown'

// Connects to data-controller="copy-to-clipboard"
export default class extends Controller {
  static targets = [
    'allIssuesTable',
    'markdownButtonMessage',
    'markdownButtonSuccessMessage'
  ]

  markdownCopy() {
    const markdonwText = NodeHtmlMarkdown.translate(
      this.allIssuesTableTarget.outerHTML,
      { bulletMarker: '-' }
    )
    navigator.clipboard.writeText(markdonwText).then(() => {
      this.markdownButtonMessageTarget.classList.add('hidden')
      this.markdownButtonSuccessMessageTarget.classList.remove('hidden')

      // reset to default state
      setTimeout(() => {
        this.markdownButtonMessageTarget.classList.remove('hidden')
        this.markdownButtonSuccessMessageTarget.classList.add('hidden')
      }, 2000)
    })
  }
}
