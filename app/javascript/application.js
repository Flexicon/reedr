// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import AOS from "aos"
import "controllers"

// Init animate on scroll 🪄
AOS.init({ duration: 600 });
