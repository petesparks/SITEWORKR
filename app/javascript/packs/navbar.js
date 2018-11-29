function initUpdateNavbarOnScroll() {
  var navbar = document.querySelector('.navbar-home');
  if (navbar) {
    window.addEventListener('scroll', function(e) {
      if (window.scrollY >= window.innerHeight - 100) {
        navbar.classList.remove('navbar-home');
      } else {
        navbar.classList.add('navbar-home');
      }
    });
  }
}

export { initUpdateNavbarOnScroll };
