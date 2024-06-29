import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modals"
export default class extends Controller {
  connect() {
    document.getElementById("text-entry").focus()
  }
  close(e) {
    e.preventDefault();
    const animElement = document.getElementById("anim");
    animElement.classList.remove('animate-expand');
    animElement.classList.add('animate-close');
    
    animElement.addEventListener('animationend', () => {
      const modal = document.querySelector("turbo-frame#modal");
      modal.innerHTML = "";
      modal.removeAttribute("src");
      modal.removeAttribute("complete");

      if (e.target.tagName === 'A') {
        window.location = e.target.href;
      }
    }, { once: true });
  }
}
