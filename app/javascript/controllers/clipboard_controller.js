import { Controller } from '@hotwired/stimulus'
import { NodeHtmlMarkdown } from 'node-html-markdown'

// Connects to data-controller="copy-to-clipboard"
export default class extends Controller {
  static targets = [
    'allIssuesTable',
    'markdownButtonMessage',
    'markdownButtonSuccessMessage',
    'urlButtonMessage',
    'urlButtonSuccessMessage',
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

  urlCopy() {
    navigator.clipboard.writeText(document.location.href).then(() => {
      this.urlButtonMessageTarget.classList.add('hidden')
      this.urlButtonSuccessMessageTarget.classList.remove('hidden')

      // reset to default state
      setTimeout(() => {
        this.urlButtonMessageTarget.classList.remove('hidden')
        this.urlButtonSuccessMessageTarget.classList.add('hidden')
      }, 2000)
    })
  }
}
