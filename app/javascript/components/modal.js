const initModal = () => {
  $('#myModal').on('shown.bs.modal', function () {
    $('#myInput').trigger('focus')
  });
}
