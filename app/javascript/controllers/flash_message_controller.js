import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  yeet() {
    this.element.remove();
  }
}
