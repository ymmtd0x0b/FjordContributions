import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="toast"
export default class extends Controller {
  static targets = ['toast']

  connect() {
    this.toastTarget.classList.add('animate-fade-in-top')
    this.toastTarget.classList.remove('hidden')

    const displayTime = 3000
    setTimeout(() => {
      this.toastTarget.classList.add('animate-fade-out-bottom')
    }, displayTime)

    const fadeOutDelay = 700
    const displayFinishTime = displayTime + fadeOutDelay
    setTimeout(() => {
      this.toastTarget.remove()
    }, displayFinishTime)
  }
}
