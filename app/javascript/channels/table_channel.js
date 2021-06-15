import consumer from "./consumer";

const initTableCable = () => {
  const orderItemsContainer = document.getElementById('order-items-table');
  if (orderItemsContainer) {
    const id = orderItemsContainer.dataset.tableId;

    consumer.subscriptions.create({ channel: "TableChannel", id: id }, {
      received(data) {
        const responseArray = data.split(',');
        const orderItemId = responseArray[0];
        const orderItemStatus = responseArray[1];
        const orderItemStatusDiv = document.getElementById(`${orderItemId}`)
        if (orderItemStatusDiv) {
          orderItemStatusDiv.innerText = orderItemStatus;
        };
      },
    });
  }
}

export { initTableCable };