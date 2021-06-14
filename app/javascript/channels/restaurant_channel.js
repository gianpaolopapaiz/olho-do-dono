import consumer from "./consumer";

const initRestaurantCable = () => {
  const orderItemsContainer = document.getElementById('order-items');
  if (orderItemsContainer) {
    const id = orderItemsContainer.dataset.restaurantId;

    consumer.subscriptions.create({ channel: "RestaurantChannel", id: id }, {
      received(data) {
        orderItemsContainer.insertAdjacentHTML('beforeend', data);
      },
    });
  }
  
}

export { initRestaurantCable };