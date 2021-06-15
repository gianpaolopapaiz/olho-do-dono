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
        const orderItemRemoveDiv = document.getElementById(`${orderItemId}-remove`)
        if (orderItemStatusDiv) {
          orderItemStatusDiv.innerText = orderItemStatus;
          orderItemRemoveDiv.innerText = '';
        };
      },
    });
  }
}

export { initTableCable };