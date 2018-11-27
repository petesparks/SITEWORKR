
const hire = document.querySelector("#hire");
if (hire) {
  hire.addEventListener("click", (event) => {
    hire.classList.add("button-none");

  });
}

const accept = document.getElementById("accept");
if (accept) {
  accept.addEventListener("click", (event) => {
    accept.classList.add("button-none");
  });
}

const finish = document.getElementById("finish");
if (finish) {
  finish.addEventListener("click", (event) => {
    finish.classList.add("button-none");
  });
}
