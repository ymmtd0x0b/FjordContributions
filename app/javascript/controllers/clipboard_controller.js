import { Controller } from '@hotwired/stimulus'
import clipboardInit from '../clipboards'

// Connects to data-controller="tooltip"
export default class extends Controller {
  connect() {
    clipboardInit()
  }
}
