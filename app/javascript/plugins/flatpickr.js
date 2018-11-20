import flatpickr from "flatpickr"
import "flatpickr/dist/themes/airbnb.css" // Note this is important!

import rangePlugin from "flatpickr/dist/plugins/rangePlugin"

flatpickr("#start_date", {
  altInput: true,
  plugins: [new rangePlugin({ input: "#end_date"})],
  disable: JSON.parse(document.querySelector(".user-card").dataset.dates),
  inline: true
})

