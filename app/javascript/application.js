// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails';
import AOS from 'aos';
import 'controllers';

// Initialize AOS on page load
document.addEventListener('turbo:load', () => {
  AOS.init();
});

// Refresh AOS after Turbo renders new content
document.addEventListener('turbo:render', () => {
  Array.from(document.getElementsByClassName('aos-init')).forEach((el) => {
    el.classList.remove('aos-init', 'aos-animate');
  });

  setTimeout(() => {
    AOS.refresh();
  }, 100);
});
