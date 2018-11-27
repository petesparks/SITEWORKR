import swal from 'sweetalert';

function bindSweetAlertButtonDemo() {
  var swalButton = document.querySelector('sweet-alert-demo');
  if (swalButton) { // protect other pages
    swalButton.addEventListener('click', (e) => {
      e.preventDefault()
      swal({
        title: "Are you sure?",
        text: "Once deleted, you will not be able to recover this imaginary file!",
        icon: "warning",
        buttons: true,
        dangerMode: true,
      })
      .then((match) => {
        if (match) {
          swalButton.click();
        } else {
          swal("Your imaginary file is safe!");
        }
      });
    });
  }
}

bindSweetAlertButtonDemo()

