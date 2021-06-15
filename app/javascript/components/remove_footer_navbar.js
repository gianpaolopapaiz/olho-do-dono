const removeFooterNavbar = () => {
  const navbar = document.getElementById('navbar');
  const footer = document.getElementById('footer');
  navbar.style.display = 'none';
  footer.style.display = 'none';
}

export { removeFooterNavbar };