import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="switching-tabs"
export default class extends Controller {
  static targets = ['tab']

  connect() {
    const activeClasses = [
      'inline-block',
      'p-4',
      'text-blue-600',
      'border-b-2',
      'border-blue-600',
      'rounded-t-lg',
      'active'
    ]
    const inactiveClasses = [
      'inline-block',
      'p-4',
      'border-b-2',
      'border-transparent',
      'rounded-t-lg',
      'hover:text-gray-600',
      'hover:border-gray-300'
    ]

    const curent = document.location.pathname + document.location.search
    this.tabTargets.forEach((tab) => {
      if (tab.getAttribute('href') === curent) {
        tab.classList.remove()
        tab.classList.add(...activeClasses)
      } else {
        tab.classList.remove()
        tab.classList.add(...inactiveClasses)
      }
    })
  }
}
