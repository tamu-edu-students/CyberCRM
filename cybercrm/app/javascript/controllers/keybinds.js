document.addEventListener('DOMContentLoaded', function() {
  document.addEventListener('keydown', function(event) {
    if (event.ctrlKey && event.key === 'S') {
      event.preventDefault();

      const searchLink = document.getElementById('search-link');
      if (searchLink) {
        searchLink.click();
      }
    }
  });
});
