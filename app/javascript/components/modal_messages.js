import 'jquery'

const msgModal = () => {
  $('#myModal').on('shown.bs.modal', function () {
    $('#myInput').trigger('focus')
  });
}
export { msgModal };
