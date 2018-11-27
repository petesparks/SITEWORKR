
var hire = document.querySelector("#hire");
if (hire) {
  hire.addEventListener("click", (event) => {
    hire.classList.add("button-none");

  });
}

var accept = document.getElementById("accept");
if (accept) {
  accept.addEventListener("click", (event) => {
    accept.classList.add("button-none");
  });
}

var finish = document.getElementById("finish");
if (finish) {
  finish.addEventListener("click", (event) => {
    finish.classList.add("button-none");
  });
}
