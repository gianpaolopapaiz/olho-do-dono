import consumer from "./consumer";

const initTableCable = () => {
  const orderItemsContainer = document.getElementById('order-items');
  if (orderItemsContainer) {
    const id = orderItemsContainer.dataset.tableId;

    consumer.subscriptions.create({ channel: "TableChannel", id: id }, {
      received(data) {
        console.log(data); // called when data is broadcast in the cable
      },
    });
  }
  
}

export { initTableCable };