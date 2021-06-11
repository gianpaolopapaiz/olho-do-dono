const paymentReload = () => {
  const container = document.getElementById('reload-js') 
  if (container) {
    document.location.reload(true);  
  }
}

export { paymentReload };