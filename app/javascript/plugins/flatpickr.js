import flatpickr from "flatpickr"
import "flatpickr/dist/themes/airbnb.css" // Note this is important!

import rangePlugin from "flatpickr/dist/plugins/rangePlugin"

const card = document.querySelector(".user-card-profile")

if (card) {
  flatpickr("#start_date", {
    altInput: true,
    plugins: [new rangePlugin({ input: "#end_date"})],
    disable: JSON.parse(card.dataset.dates),
    inline: true
  })
}




