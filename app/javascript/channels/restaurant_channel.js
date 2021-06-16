import consumer from "./consumer";

const initRestaurantCable = () => {
  const orderItemsContainer = document.getElementById('order-items');
  if (orderItemsContainer) {
    const id = orderItemsContainer.dataset.restaurantId;

    consumer.subscriptions.create({ channel: "RestaurantChannel", id: id }, {
      received(data) {
        if (data.includes('remove_order_item')) {
          const responseArray = data.split(',');
          const orderItemId = responseArray[1];
          const orderItemToRemove = document.getElementById(`${orderItemId}`);
          orderItemToRemove.style.display = 'none';
        } else {
          orderItemsContainer.insertAdjacentHTML('beforeend', data);
        }
      },
    });
  }
}

export { initRestaurantCable };